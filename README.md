# MONOLOGUE
Monologue is a basic mountable blogging engine in Rails built to be easily mounted in an already existing Rails app, but it can also be used alone.

[![Build Status](https://secure.travis-ci.org/jipiboily/monologue.png)](http://travis-ci.org/jipiboily/monologue)


## Questions? Problems? Documentation?

[Questions here please](http://groups.google.com/forum/#!forum/monologue-rb)
[Issues and bugs](http://github.com/jipiboily/monologue/issues)
[Wiki](https://github.com/jipiboily/monologue/wiki/_pages)

## Features
- Rails mountable engine (fully named spaced)
- tested
- back to basics: few features
- it has post revisions (no UI to choose published revision yet, but it keeps your modification history)
- few external dependencies (no Devise or Sorcery, etc…) so we don't face problem integrating with existing Rails app.([Rails mountable engines: dependency nightmare?](http://jipiboily.com/2012/rails-mountable-engines-dependency-nightmare))
- comments handled by disqus
- enforcing [Rails cache](http://edgeguides.rubyonrails.org/caching_with_rails.html) for better performance (only support file store for now)
- runs on Heroku

### missing features
- categories
- UI for posts revisions and to manage user
- much more…see issues!


## Installation
### 1. Add the gem to your `Gemfile`
```ruby
gem "monologue"
```
And run `bundle install` to fetch the gem and update your 'Gemfile.lock'.

### 2. Route to Monologue

Add this to your route file (`config/route.rb`)
```ruby
# This line mounts Monologue's routes at the root of your application.
# This means, any requests to URLs such as /my-post, will go to Monologue::PostsController.
# If you would like to change where this engine is mounted, simply change the :at option to something different.
#
# We ask that you don't use the :as option here, as Monologue relies on it being the default of "monologue"
mount Monologue::Engine, :at => '/' # or whatever path, be it "/blog" or "/monologue"
```

### 3. Migrate Monologue's database tables
Run these commands:

1. $`bundle exec rake monologue:install:migrations`
2. $`bundle exec rake db:create` (only if this is a new project)
3. $`bundle exec rake db:migrate`


### 4. Create a user
Open your development console with `rails c`, then:
```ruby
Monologue::User.create(name: "monologue", email:"monologue@example.com", password:"my-password", password_confirmation: "my-password")
```

### 5. Configure Monologue.
This is all done in an initializer file, say `config/initializers/monologue.rb`. More on this in the [Wiki - Configuration](https://github.com/jipiboily/monologue/wiki/Configuration).

### 6. Ready
Start your server and head on [http://localhost:3000/monologue](http://localhost:3000/monologue) to log in the admin section.

### Note to Heroku users
Additionnal step: turn caching off in `config/environments/production.rb`:
```ruby
config.action_controller.perform_caching = false
```

## Enable caching
Just turn perform_caching to true in your environment config file (`config/environment/{environment}.rb):
```ruby
config.action_controller.perform_caching = true
```

**IMPORTANT**: if monologue is mounted at root ("/"), you must also add that in your `routes.rb` file, before the monologue mount:

```ruby
root to: 'monologue/posts#index'
```

## Customization
See the [Wiki - Customizations](https://github.com/jipiboily/monologue/wiki/Customizations).

## Requirements
- Rails 3.1 +
- Database: MySQL & Postgres are supported but other databases might work too.

## Contribute
Fork it, then pull request. Please add tests for your feature or bug fix.

You will need to install this before running the test suite:
  - [https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

## Thanks to

Zurb for the "social foundicons".