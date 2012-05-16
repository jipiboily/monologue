class Monologue::PostsRevision < ActiveRecord::Base
  has_and_belongs_to_many :tags
  attr_accessible :title, :content, :url, :published_at ,:tags

  before_validation :generate_url

  after_save :latest_revision_is_current

  belongs_to :post
  belongs_to :user

  validates :title, :presence => true
  validates :content, :presence => true
  validates :url, :presence => true
  validates :user_id, :presence => true
#    validates :post_id, :presence =>  true # TODO: do something about this validation on the first creation of a POST
  validates :published_at, :presence => true

  def latest_revision_is_current
    post = Monologue::Post.find(self.post_id)
    post.posts_revision_id = self.id
    post.save!
  end

  def tag!(tags)
    tags = tags.map do |tag|
      tag.strip!
      Monologue::Tag.find_or_create_by_name(tag)
    end

    self.tags = tags
  end

  private

    def generate_url
      year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
      self.title = "" if self.title.nil?
      self.url = "#{Monologue::Engine.routes.url_helpers.root_path}#{year}/#{self.title.parameterize}" if self.url.nil? || self.url.strip == ""
    end
end
