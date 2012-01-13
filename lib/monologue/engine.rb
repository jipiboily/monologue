module Monologue
  class Engine < Rails::Engine
    isolate_namespace Monologue
    
    config.generators.integration_tool :rspec
    config.generators.test_framework   :rspec
  end
end
