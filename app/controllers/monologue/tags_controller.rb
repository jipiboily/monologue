class Monologue::TagsController < Monologue::ApplicationController
  def show
    @tag = retrieve_tag
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:tag]}\""
    end
  end

  private
  def retrieve_tag
    Monologue::Tag.where("lower(name) = ?", params[:tag].downcase).first
  end
end
