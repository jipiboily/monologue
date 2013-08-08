class Monologue::TagsController < Monologue::ApplicationController
  def show
    @tag = Monologue::Tag.find_by_name(params[:tag])
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:tag]}\""
    end
  end
end
