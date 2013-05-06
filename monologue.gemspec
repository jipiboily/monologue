$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "monologue/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "monologue"
  s.version     = Monologue::VERSION
  s.authors     = ["Jean-Philippe Boily | @jipiboily"]
  s.email       = ["j@jipi.ca"]
  s.homepage    = "http://github.com/jipiboily/monologue"
  s.summary     = "Monologue is a basic blogging engine. It is a Rails mountable engine so it can be mounted in any 3.1.X + apps"
  s.description = "Monologue is a basic blogging engine. It is a Rails mountable engine so it can be mounted in any 3.1.X + apps"

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md", "deprecations.rb"]

  s.add_dependency "rails", ">= 3.1.3"
  s.add_dependency "bcrypt-ruby"
  s.add_dependency "coffee-rails"
  s.add_dependency "truncate_html"
  s.add_dependency "jquery-rails"
  s.add_dependency "ckeditor"

  s.add_development_dependency "rspec-rails", "~> 2.8"
  s.add_development_dependency 'factory_girl_rails', '~> 1.4.0'
  s.add_development_dependency "capybara", "~> 1.1.4"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "mysql2"

  s.add_development_dependency "sqlite3"
end