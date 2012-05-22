class Monologue::TagsController < Monologue::ApplicationController
  def show()
    @tag= Monologue::Tag.find_by_name(params[:tag])
    if @tag
      @page =nil
      @posts = posts_with(@tag)
    else
      redirect_to :root
    end
  end

  private
    def posts_with(tag)
      tag.posts.where(:published => true)
    end
end
