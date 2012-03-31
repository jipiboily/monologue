module Monologue
  class Post < ActiveRecord::Base
    has_many :posts_revisions, dependent: :destroy

    accepts_nested_attributes_for :posts_revisions
    attr_accessible :posts_revisions_attributes
    attr_accessible :published

    
    
    scope :default, includes(:posts_revisions).where("posts_revision_id = monologue_posts_revisions.id").order("published_at DESC")
    scope :published, default.where(published: true)

    validates :posts_revision_id, uniqueness: true

    def just_the_revision_one_before
      self.posts_revisions.where("post_id = ?", self.id).order("monologue_posts_revisions.updated_at DESC").offset(1).limit(1).first
    end

    def latest_revision
      self.posts_revisions.where("post_id = ?", self.id).order("monologue_posts_revisions.updated_at DESC").limit(1).first
    end

    def self.page p
      per_page = Monologue.posts_per_page || 10
      set_total_pages(per_page)
      p = (p.nil? ? 0 : p.to_i - 1)
      offset =  (p==0 ? 0 : p * per_page)
      self.limit(per_page).offset(offset)
    end

    def self.total_pages
      @number_of_pages
    end

    def self.set_total_pages per_page
      @number_of_pages = self.count / per_page + ( self.count % per_page == 0 ? 0 : 1 )
    end
  end
end
