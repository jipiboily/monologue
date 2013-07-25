source "http://rubygems.org"

# Declare your gem's dependencies in monologue.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem "sass-rails"
gem "coffee-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
#gem 'ruby-debug'
#gem 'ruby-debug19'

group :development, :test do
  gem "thin"
  gem 'rails', '3.2.8'
  gem 'pry'

  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gem 'coveralls', require: false

gem 'pg'
