Monologue.site_name            = "@jipiboily / Jean-Philippe Boily"
Monologue.site_subtitle        = "my own place online"
Monologue.site_url             = "http://jipiboily.com"

Monologue.meta_description     = "This is my personal blog about Rails, Monologue, programming, etc..."
Monologue.meta_keyword         = "rails, programming, monologue, ruby"

Monologue.admin_force_ssl       = false
Monologue.posts_per_page      = 10

Monologue.disqus_shortname     = "jipiboily"

# LOCALE
Monologue.twitter_locale       = "en" # "fr"
Monologue.facebook_like_locale = "en_US" # "fr_CA"
Monologue.google_plusone_locale = "en"

# Monologue.layout               = "layouts/application"

# ANALYTICS
# Monologue.gauge_analytics_site_id = "YOUR COGE FROM GAUG.ES"
# Monologue.google_analytics_id = "YOUR GA CODE"

Monologue.sidebar = ["latest_posts", "latest_tweets","categories","tag_cloud"]


#SOCIAL
Monologue.twitter_username        = "jipiboily"
Monologue.facebook_url            = "https://www.facebook.com/jipiboily"
Monologue.google_plus_account_url = "https://plus.google.com/u/1/115273180419164295760/posts"
Monologue.linkedin_url            = "http://www.linkedin.com/in/jipiboily"
Monologue.github_username         = "jipiboily"
Monologue.show_rss_icon           = true


# CACHE
  # ActionController::Base.perform_caching = true
  # ActionController::Base.page_cache_directory =  = Rails.public_path + "/my-cache-dir"
Monologue::PageCache.enabled = true
Monologue::PageCache.wipe_enabled = true