class Monologue::PostsRevision < ActiveRecord::Base
  attr_accessible :title, :content, :url, :published_at

  before_validation :generate_url

  after_save :latest_revision_is_current
    
  belongs_to :post
  belongs_to :user
  
  validates :title, :presence =>  true
  validates :content, :presence =>  true
  validates :url, :presence =>  true
  validate :url_do_not_start_with_slash
  validate :url_is_unique
  validates :user_id, :presence =>  true
#    validates :post_id, :presence =>  true # TODO: do something about this validation on the first creation of a POST
  validates :published_at, :presence =>  true
  
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
      return Monologue::PostsRevision.where("url = ?", self.url).count > 0
    else
      return Monologue::PostsRevision.where("url = ? and post_id <> ?", self.url, self.post_id).count > 0
    end
  end

  private 

    def generate_url
      year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
      return if self.title.blank?
      base_title = "#{year}/#{self.title.parameterize}"
      url_empty = self.url.nil? || self.url.strip == ""
      self.url = base_title if url_empty
      while self.url_exists? && url_empty
        i ||= 1
        self.url = "#{base_title}-#{i}"
        i += 1
      end
    end
end
