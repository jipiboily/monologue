module Monologue
  class Post < ActiveRecord::Base
    has_many :posts_revisions, dependent: :destroy
    accepts_nested_attributes_for :posts_revisions
    
    scope :published, includes(:posts_revisions).where("posts_revision_id = monologue_posts_revisions.id").where(published: true).order("published_at DESC")
    
    validates :posts_revision_id, uniqueness: true
  end
end
