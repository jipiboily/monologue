class Monologue::Admin::PostsController < Monologue::Admin::BaseController
  respond_to :html
  
  def index
    @posts = Monologue::Post.includes(:posts_revisions).joins(:posts_revisions).order("published_at DESC").all
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
 
    if @post.save
      redirect_to edit_admin_post_path(@post), notice: 'Monologue created'
    else
      render :action => "new"
    end
  end
  
  def edit
    @post = Monologue::Post.includes(:posts_revisions).find(params[:id])
    @revision = @post.posts_revisions.last
  end
  
  def update
    @post = Monologue::Post.includes(:posts_revisions).find(params[:id])
    @post.published = params[:post][:published]
    @revision = @post.posts_revisions.build(params[:post][:posts_revision])
    @revision.user_id = current_user.id
    if @post.save
      redirect_to edit_admin_post_path(@post), notice: 'Monologue saved'
    else
      render :edit
    end
  end
  
  def destroy
    post = Monologue::Post.find(params[:id])
    if post.destroy
      redirect_to admin_posts_path, notice: "Monologue removed"
    else
      redirect_to admin_posts_path, alert: "Failed to remove monologue!"
    end
  end
end