module Monologue
  class PostsRevision < ActiveRecord::Base
    attr_accessible :title, :content, :url, :published_at

    before_validation :generate_url


    after_save :latest_revision_is_current
    
    belongs_to :post
    belongs_to :user
    
    validates :title, :presence =>  true
    validates :content, :presence =>  true
    validates :url, :presence =>  true
    validate :url_do_not_start_with_slash
    validates :user_id, :presence =>  true
#    validates :post_id, :presence =>  true # TODO: do something about this validation on the first creation of a POST
    validates :published_at, :presence =>  true
    
    def latest_revision_is_current
      post = Monologue::Post.find(self.post_id)
      post.posts_revision_id = self.id
      post.save!
    end

    def full_url
      "#{Monologue::Engine.routes.url_helpers.root_path}#{self.url}"
    end

    def url_do_not_start_with_slash
      errors.add(:url, I18n.t("activerecord.errors.models.monologue/posts_revision.attributes.url.start_with_slash")) if self.url.start_with?("/")
    end

    private 

      def generate_url
        year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
        self.title = "" if self.title.nil?
        self.url = "#{year}/#{self.title.parameterize}" if self.url.nil? || self.url.strip == ""
      end
  end
end