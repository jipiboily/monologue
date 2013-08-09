class Monologue::PostsController < Monologue::ApplicationController
  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.published.page(@page)
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("monologue_posts_revisions.url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("monologue_posts_revisions.url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
      return
    end
    @revision = @post.active_revision
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
  end
end
