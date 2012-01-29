module Monologue
  class Post < ActiveRecord::Base
    has_many :posts_revisions
    accepts_nested_attributes_for :posts_revisions
    
    scope :published_revision, joins(:posts_revisions).where("posts_revision_id = monologue_posts_revisions.id")
    validates :posts_revision_id, uniqueness: true
  end
end
