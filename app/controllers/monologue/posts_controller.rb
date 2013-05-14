class Monologue::PostsController < Monologue::ApplicationController
  caches_page :index, :show, :feed , if: Proc.new { monologue_page_cache_enabled? }

  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.published.page(@page)
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
    end
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
  end
end