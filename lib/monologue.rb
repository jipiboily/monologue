require "monologue/engine"

module Monologue
  mattr_accessor :disqus_shortname,
                 :site_name,
                 :site_url,
                 :meta_description,
                 :meta_keyword
end