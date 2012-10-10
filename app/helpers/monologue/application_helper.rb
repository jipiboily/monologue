module Monologue
  module ApplicationHelper
    include Monologue::Engine.routes.url_helpers if ENV["RAILS_ENV"] == "test" # TODO: try and see why this is needed for specs to pass
    #Number of sizes defined in the css
    NUMBER_OF_LABEL_SIZES = 5

    def monologue_admin_form_for(object, options = {}, &block)
      options[:builder] = MonologueAdminFormBuilder
      form_for(object, options, &block)
    end

    def monologue_accurate_title
      content_for?(:title) ? ((content_for :title) + " | #{Monologue.site_name}") : Monologue.site_name
    end

    def sidebar_section_for(title, &block)
      content_tag(:section, :class => 'widget') do
        content_tag(:header, content_tag(:h1, title)) +
            capture(&block)
      end
    end

    def rss_head_link
      tag("link", :href => feed_url, :rel => "alternate", :title => "RSS", :type => "application/rss+xml")
    end

    def rss_icon
      social_icon("rss", feed_url, Monologue.show_rss_icon)
    end

    def github_icon
      social_icon("github", "http://github.com/#{Monologue.github_username}", Monologue.github_username)
    end

    def twitter_icon
      social_icon("twitter", "http://twitter.com/#{Monologue.twitter_username}", Monologue.twitter_username)
    end

    def linkedin_icon
      social_icon("linkedin", Monologue.linkedin_url, Monologue.linkedin_url)
    end

    def googleplus_icon
      social_icon("google-plus", Monologue.google_plus_account_url, Monologue.google_plus_account_url)
    end

    def facebook_icon
      social_icon("facebook", Monologue.facebook_url, Monologue.facebook_url)
    end

    def absolute_image_url(url)
       return url if url.starts_with? "http"
       request.protocol + request.host + url
    end

    # TODO: That should be move in TagHelper if I manage to get that loaded
    def tag_url(tag)
      "#{Monologue::Engine.routes.url_helpers.root_path}tags/#{tag.name.downcase}"
    end

    def label_for_tag(tag, min, max)
      "label-size-#{size_for_tag(tag, min, max)}"
    end

    def size_for_tag(tag, min, max)
      #logarithmic scaling based on the number of occurrences of each tag
      if min<max && tag.frequency>0
        1 + ((NUMBER_OF_LABEL_SIZES-1)*(log_distance_to_min(tag.frequency, min))/log_distance_to_min(max, min)).round
      else
        1
      end
    end

    private
    def social_icon foundicon, url, setting
      return if setting.nil? || !setting
      content_tag :a, :href => url, :class => "social", :target => "_blank" do
        content_tag :i, :class => "foundicon-#{foundicon}" do # using an empty content tag for foundicons to appear. TODO: try to do otherwise and use only tag method
        end
      end
    end

    def log_distance_to_min(value, min)
      Math.log(value)-Math.log(min)
    end

  end
end
