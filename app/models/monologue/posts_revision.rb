module Monologue
  class PostsRevision < ActiveRecord::Base
    belongs_to :posts
    
    validates :title, presence: true
    validates :content, presence: true
    validates :url, presence: true
    validates :user_id, presence: true
#    validates :post_id, presence: true # TODO: do something about this validation on the first creation of a POST
    validates :published_at, presence: true
    
  end
end
