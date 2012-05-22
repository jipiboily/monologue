class Monologue::Admin::PostsController < Monologue::Admin::BaseController
  respond_to :html
  cache_sweeper Monologue::PostsSweeper, :only => [:create, :update, :destroy]
  before_filter :load_post_and_revisions, :only => [:edit, :update]

  def index
    @posts = Monologue::Post.default
  end

  def new
    @post = Monologue::Post.new
    @revision = @post.posts_revisions.build
  end

  def create
    params[:post][:posts_revisions_attributes] = {}
    params[:post][:posts_revisions_attributes][0] = params[:post][:posts_revision]
    params[:post].delete("posts_revision")
    @post = Monologue::Post.new(params[:post])
    @revision = @post.posts_revisions.first
    @revision.user_id = current_user.id
    save_tags()
    if @post.save
      redirect_to edit_admin_post_path(@post), :notice => 'Monologue created'
    else
      render :new
    end
  end

  def edit
    @revision = @post.active_revision
  end

  def update
    @post.published = params[:post][:published]
    @revision = @post.posts_revisions.build(params[:post][:posts_revision])
    @revision.user_id = current_user.id
    save_tags()
    if @post.save
      redirect_to edit_admin_post_path(@post), :notice => 'Monologue saved'
    else
      render :edit
    end
  end

  def destroy
    post = Monologue::Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, :notice => "Monologue removed"
    else
      redirect_to admin_posts_path, :alert => "Failed to remove monologue!"
    end
  end

  private
  def save_tags
    @post.tag!(params[:post][:tag_list].split(","))
  end

  def load_post_and_revisions
    @post = Monologue::Post.includes(:posts_revisions).find(params[:id])
  end

  helper_method :tag_list_for

  def tag_list_for(tags)
    tags.map { |tag| tag.name }.join(", ") if tags
  end

end