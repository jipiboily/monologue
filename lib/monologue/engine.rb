require "tinymce-rails"
require "truncate_html"
module Monologue
  class Engine < Rails::Engine
    isolate_namespace Monologue



    config.generators.test_framework :rspec, :view_specs => false, :fixture => false
    config.generators.stylesheets     false
    config.generators.fixture_replacement :factory_girl
    config.generators.integration_tool :rspec

    initializer :assets do |config|
      Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    end


    ENGINE_ROOT = File.join(File.dirname(__FILE__), '../..')
    require "#{ENGINE_ROOT}/deprecations"
  end
end
