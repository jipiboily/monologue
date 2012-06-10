class Monologue::ApplicationController < ApplicationController

  layout Monologue.layout if Monologue.layout # TODO: find a way to test that. It was asked in issue #54 (https://github.com/jipiboily/monologue/issues/54)

  before_filter :recent_posts

  def recent_posts
    @recent_posts = Monologue::Post.published.limit(3)
  end

  def not_found
    # fallback to the default 404.html page from main_app.
    file = Rails.root.join('public', '404.html')
    if file.exist?
      render :file => file.cleanpath.to_s.gsub(%r{#{file.extname}$}, ''),
         :layout => false, :status => 404, :formats => [:html]
    else
      render :action => "404", :status => 404, :formats => [:html]
    end
  end
  
  
  private

    def current_user
      @current_user ||= Monologue::User.find(session[:user_id]) if session[:user_id]
    end
  
  helper_method :current_user
end
