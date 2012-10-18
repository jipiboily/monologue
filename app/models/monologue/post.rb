class Monologue::Post < ActiveRecord::Base
  has_many :posts_revisions, :dependent => :destroy
  has_many :taggings
  has_many :tags, :through => :taggings, :dependent => :destroy

  accepts_nested_attributes_for :posts_revisions
  attr_writer :tag_list
  attr_accessible :posts_revisions_attributes, :published, :tag_list

  scope :default, includes(:posts_revisions).where("posts_revision_id = monologue_posts_revisions.id").order("published_at DESC, monologue_posts.created_at DESC, monologue_posts.updated_at DESC")
  scope :published, lambda { default.where(:published => true).where("published_at <= ?", DateTime.now) }

  default_scope includes(:tags)

  validates :posts_revision_id, :uniqueness => true

  # TODO: move that in a spec helper as it only used by tests
  def just_the_revision_one_before
    self.posts_revisions.where("post_id = ?", self.id).order("monologue_posts_revisions.updated_at DESC").offset(1).limit(1).first
  end

  def latest_revision
    self.posts_revisions.where("post_id = ?", self.id).order("monologue_posts_revisions.updated_at DESC").limit(1).first
  end

  def active_revision
    Monologue::PostsRevision.find(self.posts_revision_id)
  end

  def tag!(tags)
    self.tags = tags.select { |t| t.present? }.map do |tag|
      tag.strip!
      if tag.present?
        Monologue::Tag.find_or_create_by_name(tag)
      end
    end
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
end
