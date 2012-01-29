class Monologue::Admin::PostsController < Monologue::Admin::BaseController
  def index
  end
  
  def new
    @post = Monologue::Post.new
    @post.posts_revisions.build
    
  end
  
  def create
    @post = Monologue::Post.new(params[:post])
    @post.posts_revisions.first.user_id = current_user.id
        
    respond_to do |format|
      if @post.save
        format.html { redirect_to ["admin", @post], :notice => 'Monologue created' }
        format.json { render :json => ["admin", @post], :status => :created, :location => ["admin", @post] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def update
    render :edit
  end
end