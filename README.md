# Monologue
[![Gem Version](https://badge.fury.io/rb/monologue.png)](http://badge.fury.io/rb/monologue)
[![Build Status](https://secure.travis-ci.org/jipiboily/monologue.png)](http://travis-ci.org/jipiboily/monologue)
[![Code Climate](https://codeclimate.com/github/jipiboily/monologue.png)](https://codeclimate.com/github/jipiboily/monologue)
[![Coverage Status](https://coveralls.io/repos/jipiboily/monologue/badge.png?branch=master)](https://coveralls.io/r/jipiboily/monologue?branch=master)

**THIS README IS FOR THE MASTER BRANCH AND REFLECTS THE WORK CURRENTLY EXISTING ON THE MASTER BRANCH. IF YOU ARE WISHING TO USE A NON-MASTER BRANCH OF MONOLOGUE, PLEASE CONSULT THAT BRANCH'S README AND NOT THIS ONE.**

-

Monologue is a basic mountable blogging engine in Rails built to be easily mounted in an already existing Rails app, but it can also be used alone.

## Version

This README is for a future Monologue version, that will be 0.4.X and be Rails 4 specific. See other branches for other versions (0-3-stable being the latest stable version).

## Upgrade and changes

To know how to upgrade, see [UPGRADE.md](https://github.com/jipiboily/monologue/blob/master/UPGRADE.md) file. If you want to know what changed since the last versions, see [CHANGELOG.md](https://github.com/jipiboily/monologue/blob/master/CHANGELOG.md).

## Questions? Problems? Documentation?

- [Mailing list for questions](http://groups.google.com/forum/#!forum/monologue-rb)
- [Issues and bugs](http://github.com/jipiboily/monologue/issues)
- [Wiki](https://github.com/jipiboily/monologue/wiki/_pages)
- IRC channel (on Freenode): #monologue.

## Some features
- Rails mountable engine (fully named spaced and mountable in an already existing app)
- tested
- back to basics: few features
- tags (or categories)
- RSS
- multiple users
- support for Google Analytics and Gaug.es tags
- few external dependencies (no Devise or Sorcery, etc…) so we don't face problem integrating with existing Rails app.([Rails mountable engines: dependency nightmare?](http://jipiboily.com/2012/rails-mountable-engines-dependency-nightmare))
- comments are handled by [disqus](http://disqus.com/)
- more in the [CHANGELOG](https://github.com/jipiboily/monologue/blob/master/CHANGELOG.md)

- bonus: there is a [monologue-markdown](https://github.com/jipiboily/monologue-markdown) extension

### missing features
- see [roadmap](https://github.com/jipiboily/monologue/wiki/Roadmap)!


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
mount Monologue::Engine, at: '/' # or whatever path, be it "/blog" or "/monologue"
```
For example, if you decide to mount it at  `/blog`, the admin section will be available at `/blog/monologue`.
Here we decide to use monologue as default route mounting it at `/`, it means that the admin section will directly
be available at `/monologue`.

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
1. Additionnal step: turn caching off in `config/environments/production.rb`:
```ruby
config.action_controller.perform_caching = false
```
2. If you use compiled assets, I recommend you to add `gem "tinymce-rails"` to your Gemfile otherwise you might not be able to post an article.

### Note to users
Monologue is using his own tables. If you want to use your own tables with monologue (for example the User table)
this might help you to monkey patch [Monkey Patch](https://gist.github.com/jipiboily/776d907fc932640ac59a)

## Customization
See the [Wiki - Customizations](https://github.com/jipiboily/monologue/wiki/Customizations).

## Requirements
- Rails 3.1 +
- Database: MySQL & Postgres are supported but other databases might work too.

## Authors
* Jean-Philippe Boily, [@jipiboily](https://github.com/jipiboily)
* Michael Sevestre, [@msevestre](https://github.com/msevestre)

## Contribute
Fork it, then pull request. Please add tests for your feature or bug fix.

You will need to install this before running the test suite:
  - [https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

## Thanks to

Zurb for the "social foundicons".
