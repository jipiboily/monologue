 RSpec.configure do |config|
  # From what I remember, that was for integration specs
  config.include Monologue::Engine.routes.url_helpers

  # This is for controller specs.
  # Took it from:
  #     http://stackoverflow.com/questions/7691594/how-to-test-routes-in-a-rails-3-1-mountable-engine/8140626#8140626
  #   got the link from
  #     http://stackoverflow.com/questions/5200654/how-do-i-write-a-rails-3-1-engine-controller-test-in-rspec
  config.before(:suite) do
    @routes = Monologue::Engine.routes
  end
end