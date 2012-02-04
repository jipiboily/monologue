module Monologue
  class PostsController < ApplicationController
    def index
      @posts = Monologue::Post.published_posts
    end
    
    def show
      logger.debug root_path.to_s
      post = Monologue::Post.published_posts.where("monologue_posts_revisions.url = :url", {url: root_path + params[:post_url]}).first
      @revision = post.posts_revisions.first
    end
  end
end
