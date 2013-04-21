class Monologue::PostsRevision < ActiveRecord::Base
  attr_accessible :title, :content, :url, :published_at

  before_validation :generate_url

  after_save :latest_revision_is_current

  belongs_to :post

  validates :title, :content, :url, :published_at, presence: true
  validate :url_do_not_start_with_slash
  validate :url_is_unique
#    validates :post_id, presence:  true # TODO: do something about this validation on the first creation of a POST

  #isn't it post concern?'
  def latest_revision_is_current
    #post = Monologue::Post.find(self.post_id)
    self.post.posts_revision_id = self.id
    self.post.save!
  end

  def full_url
    "#{Monologue::Engine.routes.url_helpers.root_path}#{self.url}"
  end

  def url_do_not_start_with_slash
    errors.add(:url, I18n.t("activerecord.errors.models.monologue/posts_revision.attributes.url.start_with_slash")) if self.url.start_with?("/")
  end

  def url_is_unique
    errors.add(:url, I18n.t("activerecord.errors.models.monologue/posts_revision.attributes.url.unique")) if self.url_exists?
  end

  def url_exists?
    if self.post_id.nil?
      Monologue::PostsRevision.where("url = ?", self.url).count > 0
    else
      Monologue::PostsRevision.where("url = ? and post_id <> ?", self.url, self.post_id).count > 0
    end
  end

  def last_urls_with_title(title, post_id)
    Monologue::PostsRevision.where("post_id <> ? AND title LIKE ? OR title LIKE ?", post_id, "#{title}%", "#{title}-%").select(&:title).uniq
  end

  private

    def generate_url
      year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
      return if self.title.blank?
      base_title = "#{year}/#{self.title.parameterize}"
      url_empty = self.url.blank?
      self.url = base_title if url_empty
      past_urls = last_urls_with_title(self.title, self.post_id).map(&:title)
      if past_urls.present?
        next_suffix = past_urls.sort.last.split("-").last.to_i + 1
        self.url = "#{base_title}-#{next_suffix}"
      end
    end
end
