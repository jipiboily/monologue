class Monologue::Post < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy
  before_validation :generate_url
  belongs_to :user

  scope :default,  -> {order("published_at DESC, monologue_posts.created_at DESC, monologue_posts.updated_at DESC") }
  scope :published, -> { default.where(published: true).where("published_at <= ?", DateTime.now) }

  default_scope{includes(:tags)}

  validates :user_id, presence: true
  validates :title, :content, :url, :published_at, presence: true
  validates :url, uniqueness: true
  validate :url_do_not_start_with_slash

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
      t = Monologue::Tag.find_or_create_by :name => tag
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
    per_page = Monologue::Config.posts_per_page || 10
    set_total_pages(per_page)
    p = (p.nil? ? 0 : p.to_i - 1)
    offset =  p * per_page
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
    return unless self.url.blank?
    year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
    self.url = "#{year}/#{self.title.parameterize}"
  end

  def url_do_not_start_with_slash
    errors.add(:url, I18n.t("activerecord.errors.models.monologue/post.attributes.url.start_with_slash")) if self.url.start_with?("/")
  end

end
