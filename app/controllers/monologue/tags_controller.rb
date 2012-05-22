class Monologue::TagsController < Monologue::ApplicationController
  def show()
    tag= Monologue::Tag.find_by_name(params[:tag])
    unless tag
      redirect_to :root
    else
      @page =nil
      @posts = posts_with(tag)

      if @posts
        render 'monologue/posts/index'
      else
        redirect_to :root
      end
    end
  end

  private
    def posts_with(tag)
      posts = tag.posts_revisions.map do |rev|
        #to do only for active revision and for some reason, rev.is_active? does not work.
        if rev.post.published #&& rev.is_active?
          rev.post
        end
      end
      posts.uniq!
    end
end
