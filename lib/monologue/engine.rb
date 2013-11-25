require "truncate_html"
require "ckeditor"
require "select2-rails"
require "jquery-rails"
require "sass-rails"
require "coffee-rails"

module Monologue
  class Engine < Rails::Engine
    isolate_namespace Monologue
    engine_name 'monologue'

    config.generators.test_framework :rspec, view_specs: false, fixture: false
    config.generators.stylesheets false
    config.generators.fixture_replacement :factory_girl
    config.generators.integration_tool :rspec

    initializer :assets do |config|
      Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    end

    initializer "monologue.configuration", :before => :load_config_initializers do |app|
      app.config.monologue = Monologue::Configuration.new
      Monologue::Config = app.config.monologue
    end

    ENGINE_ROOT = File.join(File.dirname(__FILE__), '../..')
    require "#{ENGINE_ROOT}/deprecations"
  end
end
