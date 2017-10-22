# Monologue
[![Gem Version](https://badge.fury.io/rb/monologue.png)](http://badge.fury.io/rb/monologue)
[![Build Status](https://secure.travis-ci.org/jipiboily/monologue.png)](http://travis-ci.org/jipiboily/monologue)
[![Code Climate](https://codeclimate.com/github/jipiboily/monologue.png)](https://codeclimate.com/github/jipiboily/monologue)
[![Coverage Status](https://coveralls.io/repos/jipiboily/monologue/badge.png?branch=master)](https://coveralls.io/r/jipiboily/monologue?branch=master)

**THIS README IS FOR THE MASTER BRANCH AND REFLECTS THE WORK CURRENTLY EXISTING ON THE MASTER BRANCH. IF YOU ARE WISHING TO USE A NON-MASTER BRANCH OF MONOLOGUE, PLEASE CONSULT THAT BRANCH'S README AND NOT THIS ONE.**

**NOT MAINTAINED ANYMORE**: This project hasn't been maintained for a while. It's pretty basic and should still work. Chances are issues and PRs might not receive the attention they deserve, at least, not quickly, if at all.

Monologue is a basic, mountable blogging engine in Rails built to be easily mounted in an already existing Rails app, but it can also be used alone.

## Version

This README is for the latest version of Monologue (0-5-stable being the latest stable version).

## Upgrade and changes

To learn how to upgrade, see [UPGRADE.md](https://github.com/jipiboily/monologue/blob/master/UPGRADE.md) file. If you want to learn what changed since the last versions, see [CHANGELOG.md](https://github.com/jipiboily/monologue/blob/master/CHANGELOG.md).

## Questions? Problems? Documentation?

- [Mailing list for questions](http://groups.google.com/forum/#!forum/monologue-rb)
- [Issues and bugs](http://github.com/jipiboily/monologue/issues)
- [Wiki](https://github.com/jipiboily/monologue/wiki/_pages)

## Some features
- Rails mountable engine (fully namespaced and mountable in an already existing app)
- tested
- back to basics: few features
- tags (or categories)
- RSS
- multiple users
- support for Google Analytics and Gaug.es tags
- few external dependencies (no Devise or Sorcery, etc…) so we don't face problem integrating with existing Rails app.([Rails mountable engines: dependency nightmare?](http://jipiboily.com/2012/rails-mountable-engines-dependency-nightmare))
- comments are handled by [disqus](http://disqus.com/)
- more in the [CHANGELOG](https://github.com/jipiboily/monologue/blob/master/CHANGELOG.md)

- Available extensions
  - [monologue-markdown](https://github.com/jipiboily/monologue-markdown)
  - [monologue_image_upload](https://github.com/msevestre/monologue_image_upload)

### missing features
- see [roadmap](https://github.com/jipiboily/monologue/wiki/Roadmap)!


## Installation
### 1. Add the gem to your `Gemfile`.
```ruby
gem 'monologue'
```
And run `bundle install` to fetch the gem and update your 'Gemfile.lock'.

### 2. Route to Monologue

Add this to your route file (`config/routes.rb`)
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

1. $`bin/rake monologue:install:migrations`
2. $`bin/rake db:create` (only if this is a new project)
3. $`bin/rake db:migrate`


### 4. Create a user
Open your development console with `bin/rails c`, then:
```ruby
Monologue::User.create(name: "monologue", email:"monologue@example.com", password:"my-password", password_confirmation: "my-password")
```

### 5. Configure Monologue.
This is all done in an initializer file, typically `config/initializers/monologue.rb`. More on this in the [Wiki - Configuration](https://github.com/jipiboily/monologue/wiki/Configuration).

### 6. Ready
Start your server and go to [http://localhost:3000/monologue](http://localhost:3000/monologue) to log in the admin section.


### Note to users
Monologue is using its own tables. If you want to use your own tables with monologue (for example the User table)
this might help you to [monkey patch](https://gist.github.com/jipiboily/776d907fc932640ac59a).

## Customization
See the [Wiki - Customizations](https://github.com/jipiboily/monologue/wiki/Customizations).

## Copy views
copy views like devise `rails g monologue:views`
or use scope: `rails g monologue:views blog`

## Requirements
- Rails 4.2.1 +
- Database: MySQL & Postgres are supported but other databases might work too.

## Authors
* Jean-Philippe Boily, [@jipiboily](https://github.com/jipiboily)
* Michael Sevestre, [@msevestre](https://github.com/msevestre)

## Contributing

In the spirit of [free software][1], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][2]
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][2]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Run `bundle exec rake db:migrate`
* Run `bundle exec rake db:setup`
* Make your changes
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request


You will need to install this before running the test suite:
  - [https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

## Thanks to

Zurb for the "social foundicons".


[1]: http://www.fsf.org/licensing/essays/free-sw.html
[2]: https://github.com/jipiboily/monologue/issues
