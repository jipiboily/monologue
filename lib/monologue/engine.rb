module Monologue
  class Engine < Rails::Engine
    isolate_namespace Monologue
    
    config.generators.test_framework :rspec, :view_specs => false, :fixture => false
    config.generators.stylesheets     false
    config.generators.fixture_replacement :factory_girl
    config.generators.integration_tool :rspec
  end
end
