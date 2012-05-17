class Monologue::PostsController < Monologue::ApplicationController
  caches_page :index, :show, :feed , :if => Proc.new { current_user.nil? }

  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.published.page(@page)
  end
  
  def show
    if current_user
      post = Monologue::Post.default.where("monologue_posts_revisions.url = :url", {:url => root_path + params[:post_url]}).first
    else
      post = Monologue::Post.published.where("monologue_posts_revisions.url = :url", {:url => root_path + params[:post_url]}).first
    end
    if post.nil?
      not_found
      return
    end
    @revision = post.posts_revisions.first
  end
  
  def feed
    @posts = Monologue::Post.published.limit(25)
  end

  def search()
    search = params[:search]
    if search.nil?
      redirect_to posts_path :notice =>  "tag empty"
    else
      tag= Monologue::Tag.find_by_name(search)
      #not sure what to do with this page yet
      @page = params[:page].nil? ? 1 : params[:page]
      @posts = tag.posts_revisions.map do |rev|
        if rev.post.published
          #to do only for active revision and for some reason, rev.is_active? does not work.
          rev.post
        end
      end
      render :index
    end
  end
end