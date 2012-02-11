# MONOLOGUE

## WARNING: THIS IS A WORK IN PROGRESS. DO NOT USE FOR NOW. THANKS!

Monologue is a somewhat basic mountable blogging engine in Rails built to be easily mounted in an already existing Rails app, but it can also be used alone.

## Features
- Rails mountable engine
- fully named spaced
- well tested
- as less external dependencies as possible (no Devise or Sorcery, etc…) so we don't face problem integrating with existing Rails app.
- comments handled by disqus
- using [Rails cache](http://edgeguides.rubyonrails.org/caching_with_rails.html) for better performance
- runs on Heroku (must disable caching in main_app)


## Installation

1. add gem
  gem "monologue"
2. bundle install
3. add this to your route file
  mount Monologue::Engine, :at => '/' # or whatever path, be it "/blog" or "/monologue"
4. bundle exec rake monologue:install:migrations
5. Create a user
  rails c
  Monologue::User.create(name: "jipiboily", email:"j@jipi.ca", password:"password", password_confirmation: "password")

## Customization

- RSS feed URL is "/feed"


## Requirements
- Rails 3.1.3 +
- Database: MySQL & Postgres support (SQLite?)

## Ideas for the future

- use [jQuery Waypoints](http://imakewebthings.github.com/jquery-waypoints/) to suggest another article (might be chosen from and?) once the article is read.
	- An example: [See the "recommended story" once you reach the bottom of article](http://www.readwriteweb.com/archives/the_other_1_people_who_still_use_ie6.php)

- plugins
- themes (with Deface)

- easy contact form for an about page
- configurations in the database

- multiple sites with only one intance

## Contribute

Fork it, the pull request. Please add tests for your feature or bug fix.