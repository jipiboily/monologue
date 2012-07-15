require "monologue/engine"

module Monologue
  mattr_accessor :disqus_shortname,
                 :site_name,
                 :site_subtitle,
                 :site_url,
                 :meta_description,
                 :meta_keyword,
                 :twitter_username,
                 :twitter_locale,
                 :facebook_like_locale,
                 :google_plusone_locale,
                 :admin_force_ssl,
                 :posts_per_page,
                 :google_analytics_id,
                 :layout,
                 :sidebar
end