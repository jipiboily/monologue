class Monologue::Post < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy
  before_validation :generate_url
  belongs_to :user


  attr_accessible :title, :content, :url, :published, :published_at, :tag_list

  scope :default, order("published_at DESC, monologue_posts.created_at DESC, monologue_posts.updated_at DESC")
  scope :published, lambda { default.where(published: true).where("published_at <= ?", DateTime.now) }

  default_scope includes(:tags)

  validates :user_id, presence: true
  validates :title, :content, :url, :published_at, presence: true
  validate :url_do_not_start_with_slash
  validate :url_is_unique
  #def latest_revision
  #  self.posts_revisions.where("post_id = ?", self.id).order("monologue_posts_revisions.updated_at DESC").limit(1).first
  #end
  #
  #def active_revision
  #  Monologue::PostsRevision.find(self.posts_revision_id)
  #end

  def tag_list= tags_attr
    self.tag!(tags_attr.split(","))
  end

  def tag_list
    self.tags.map { |tag| tag.name }.join(", ") if self.tags
  end

  def tag!(tags_attr)
    # clean tags from removed tags
    self.tags.map { |tag| self.taggings.find_by_tag_id(tag.id).destroy unless tags_attr.include?(tag.name) }
    self.reload unless self.new_record?
    # add tags
    tags_attr.map { |t| t.strip }.reject(&:blank?).map do |tag|
      t = Monologue::Tag.find_or_create_by_name(tag)
      self.tags << t unless self.tags.include?(t)
    end
  end

  def full_url
    "#{Monologue::Engine.routes.url_helpers.root_path}#{self.url}"
  end

  def published_in_future?
    self.published && self.published_at > DateTime.now
  end

  def self.page p
    per_page = Monologue.posts_per_page || 10
    set_total_pages(per_page)
    p = (p.nil? ? 0 : p.to_i - 1)
    offset = (p==0 ? 0 : p * per_page)
    self.limit(per_page).offset(offset)
  end

  def self.total_pages
    @number_of_pages
  end

  def self.set_total_pages per_page
    @number_of_pages = self.count / per_page + (self.count % per_page == 0 ? 0 : 1)
  end

  private

  def generate_url
    year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
    return if self.title.blank?
    base_title = "#{year}/#{self.title.parameterize}"
    url_empty = self.url.blank?
    self.url = base_title if url_empty
    past_urls = last_urls_with_title(self.title, self.id).map(&:title)
    if past_urls.present?
      next_suffix = past_urls.sort.last.split("-").last.to_i + 1
      self.url = "#{base_title}-#{next_suffix}"
ra    end
  end

  def last_urls_with_title(title, post_id)
    Monologue::Post.where("id <> ? AND title LIKE ? OR title LIKE ?", post_id, "#{title}%", "#{title}-%").select(&:title).uniq
  end

  def url_do_not_start_with_slash
    errors.add(:url, I18n.t("activerecord.errors.models.monologue/post.attributes.url.start_with_slash")) if self.url.start_with?("/")
  end

  def url_is_unique
    errors.add(:url, I18n.t("activerecord.errors.models.monologue/post.attributes.url.unique")) if url_exists?
  end

  def url_exists?
    if self.id.nil?
      Monologue::Post.where("url = ?", self.url).count > 0
    else
      Monologue::Post.where("url = ? and id <> ?", self.url, self.id).count > 0
    end
  end
end
