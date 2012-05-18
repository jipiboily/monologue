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
    @revision = post.active_revision
  end
  
  def feed
    @posts = Monologue::Post.published.limit(25)
  end

  def search()
    search = params[:search]
    if search.nil?
      redirect_to posts_path
    else
      tag= Monologue::Tag.find_by_name(search)
      unless tag
        redirect_to posts_path
      else
        #not sure what to do with this page yet
        @page =nil
        @posts = post_using(tag)
        render :index
      end
    end
  end

private
  def post_using(tag)
    posts = tag.posts_revisions.map do |rev|
      #to do only for active revision and for some reason, rev.is_active? does not work.
      if rev.post.published #&& rev.is_active?
        rev.post
      end
    end
    posts.uniq!
  end
end