class Monologue::Admin::PostsController < Monologue::Admin::BaseController
  respond_to :html
  cache_sweeper Monologue::PostsSweeper, only: [:create, :update, :destroy]
  before_filter :load_post, only: [:edit, :update]
  
  def index
    @posts = Monologue::Post.default
  end

  def new
    @post = Monologue::Post.new
  end
  
  ## Preview a post without saving.
  def preview
    # mockup our models for preview.
    @post = Monologue::Post.new(params[:post])
    @post.user_id = monologue_current_user.id
    @post.published_at = Time.zone.now
    
    # render it exactly as it would display when live.
    render "/monologue/posts/show", layout: Monologue.layout || "/layouts/monologue/application"
  end
  
  def create
    @post = Monologue::Post.new(params[:post])
    @post.user_id = monologue_current_user.id
    if @post.save
      prepare_flash_and_redirect_to_edit()
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.update_attributes! params[:post]
    if @post.save
      prepare_flash_and_redirect_to_edit()
    else
      render :edit
    end
  end

  def destroy
    post = Monologue::Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, notice:  I18n.t("monologue.admin.posts.delete.removed")
    else
      redirect_to admin_posts_path, alert: I18n.t("monologue.admin.posts.delete.failed")
    end
  end

private
  def load_post
    @post = Monologue::Post.find(params[:id])
  end

  def prepare_flash_and_redirect_to_edit
    if @post.published_in_future? && ActionController::Base.perform_caching
      flash[:warning] = I18n.t("monologue.admin.posts.#{params[:action]}.saved_with_future_date_and_cache")
    else
      flash[:notice] =  I18n.t("monologue.admin.posts.#{params[:action]}.saved")
    end
    redirect_to edit_admin_post_path(@post)
  end
end