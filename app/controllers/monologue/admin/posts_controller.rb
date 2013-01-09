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
    @post = Monologue::Post.new(params[:post])
    @post.user_id = current_user.id
    @revision = @post.posts_revisions.first
    if @post.save
      if @post.published_in_future? && ActionController::Base.perform_caching
        flash[:warning] = I18n.t("monologue.admin.posts.create.created_with_future_date_and_cache")
      else
        flash[:notice] =  I18n.t("monologue.admin.posts.create.created")
      end
      redirect_to edit_admin_post_path(@post)
    else
      render :new
    end
  end

  def edit
    @revision = @post.active_revision
    @revision.id = nil # make sure we create a new revision and not update that one. TODO: find something cleaner
  end

  def update
    @post.update_attributes! params[:post]
    @revision = @post.posts_revisions.last
    if @post.save
      if @post.published_in_future? && ActionController::Base.perform_caching
        flash[:warning] =  I18n.t("monologue.admin.posts.update.saved_with_future_date_and_cache")
      else
        flash[:notice] =  I18n.t("monologue.admin.posts.update.saved")
      end
      redirect_to edit_admin_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Monologue::Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, :notice =>  I18n.t("monologue.admin.posts.delete.removed")
    else
      redirect_to admin_posts_path, :alert => I18n.t("monologue.admin.posts.delete.failed")
    end
  end

  private
  def load_post_and_revisions
    @post = Monologue::Post.includes(:posts_revisions).find(params[:id])
  end
end