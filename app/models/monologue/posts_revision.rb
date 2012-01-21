module Monologue
  class PostsRevision < ActiveRecord::Base
    belongs_to :posts
    
    validates :title, presence: true
    validates :content, presence: true
    validates :url, presence: true
    validates :user_id, presence: true
    validates :post_id, presence: true
    validates :published_at, presence: true
    
  end
end
