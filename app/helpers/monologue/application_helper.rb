module Monologue
  module ApplicationHelper
    include Monologue::Engine.routes.url_helpers if ENV["RAILS_ENV"] == "test" # TODO: try and see why this is needed for specs to pass
    #Why aren't they loaded by default?
    include Monologue::HtmlHelper
    include Monologue::TagsHelper

    def monologue_admin_form_for(object, options = {}, &block)
      options[:builder] = MonologueAdminFormBuilder
      form_for(object, options, &block)
    end

    def monologue_accurate_title
      content_for?(:title) ? ((content_for :title) + " | #{Monologue::Config.site_name}") : Monologue::Config.site_name
    end

    def rss_head_link
      tag("link", href: feed_url, rel: "alternate", title: "RSS", type: "application/rss+xml")
    end

    def rss_icon
      social_icon("rss", feed_url, Monologue::Config.show_rss_icon)
    end

    def github_icon
      social_icon("github", "http://github.com/#{Monologue::Config.github_username}", Monologue::Config.github_username)
    end

    def twitter_icon
      social_icon("twitter", "http://twitter.com/#{Monologue::Config.twitter_username}", Monologue::Config.twitter_username)
    end

    def linkedin_icon
      social_icon("linkedin", Monologue::Config.linkedin_url, Monologue::Config.linkedin_url)
    end

    def googleplus_icon
      social_icon("google-plus", Monologue::Config.google_plus_account_url, Monologue::Config.google_plus_account_url)
    end

    def facebook_icon
      social_icon("facebook", Monologue::Config.facebook_url, Monologue::Config.facebook_url)
    end

    def absolute_image_url(url)
      return url if url.starts_with? "http"
      request.protocol + request.host + url
    end

    def social_icon(foundicon, url, setting)
      return if setting.nil? || !setting
      content_tag :a, href: url, class: "social", target: "_blank" do
        content_tag :i, class: "foundicon-#{foundicon}" do # using an empty content tag for foundicons to appear. TODO: try to do otherwise and use only tag method
        end
      end
    end
  end
end
