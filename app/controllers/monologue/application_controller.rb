class Monologue::ApplicationController < ApplicationController

  layout Monologue.layout if Monologue.layout # TODO: find a way to test that. It was asked in issue #54 (https://github.com/jipiboily/monologue/issues/54)

  before_filter :recent_posts, :all_tags

  def recent_posts
    @recent_posts = Monologue::Post.published.limit(3)
  end

  def all_tags
    @tags = Monologue::Tag.all(:order => "name").select{|t| t.frequency>0}
    #could use minmax here but it's only supported with ruby > 1.9'
    @tags_frequency_min = @tags.map{|t| t.frequency}.min
    @tags_frequency_max = @tags.map{|t| t.frequency}.max
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
      @monologue_current_user ||= Monologue::User.find(session[:monologue_user_id]) if session[:monologue_user_id]
    end

    def monologue_page_cache_enabled?
      current_user.nil? && Monologue::PageCache.enabled
    end

  helper_method :current_user, :monologue_page_cache_enabled?
end
