$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "monologue/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "monologue"
  s.version     = Monologue::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Monologue."
  s.description = "TODO: Description of Monologue."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
