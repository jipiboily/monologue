class Monologue::Admin::PostsController < Monologue::Admin::BaseController
  respond_to :html
  before_filter :load_post_and_revisions, only: [:edit, :update]

  def index
    @posts = Monologue::Post.default
  end

  def new
    @post = Monologue::Post.new
    @revision = @post.posts_revisions.build
  end

  ## Preview a post without saving.
  def preview
    # mockup our models for preview.
    @post = Monologue::Post.new post_params
    @post.user_id = monologue_current_user.id
    @revision = @post.posts_revisions.first
    @revision.post = @post
    @revision.published_at = Time.zone.now

    # render it exactly as it would display when live.
    render "/monologue/posts/show", layout: Monologue.layout || "/layouts/monologue/application"
  end

  def create
    @post = Monologue::Post.new post_params
    @post.user_id = monologue_current_user.id
    @revision = @post.posts_revisions.first
    if @post.save
      prepare_flash_and_redirect_to_edit()
    else
      render :new
    end
  end

  def edit
    @revision = @post.active_revision
    @revision.id = nil # make sure we create a new revision and not update that one. TODO: find something cleaner
  end

  def update
    @post.update! post_params
    @revision = @post.posts_revisions.last
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
  def load_post_and_revisions
    @post = Monologue::Post.includes(:posts_revisions).find(params[:id]).references(:posts_revisions)
  end

  def prepare_flash_and_redirect_to_edit
    if @post.published_in_future? && ActionController::Base.perform_caching
      flash[:warning] = I18n.t("monologue.admin.posts.#{params[:action]}.saved_with_future_date_and_cache")
    else
      flash[:notice] =  I18n.t("monologue.admin.posts.#{params[:action]}.saved")
    end
    redirect_to edit_admin_post_path(@post)
  end

  def post_params
    params.require(:post).permit(:published, :tag_list,
				 :posts_revisions_attributes => [
				    :title,
				    :content,
				    :url,
				    :published_at
				 ])
  end
end
