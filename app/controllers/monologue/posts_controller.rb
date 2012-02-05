class Monologue::PostsController < Monologue::ApplicationController
  def index
    @posts = Monologue::Post.published
  end
  
  def show
    logger.debug root_path.to_s
    post = Monologue::Post.published.where("monologue_posts_revisions.url = :url", {url: root_path + params[:post_url]}).first
    @revision = post.posts_revisions.first
  end
  
  def feed
    @posts = Monologue::Post.published.limit(25)
  end
end