# MONOLOGUE

Somewhat basic mountable blogging engine in Rails built to be easily mounted in an already existing Rails app, but it can also be used alone.

## Features
- Rails mountable engine
- fully named spaced
- well tested
- as less external dependencies as possible (no Devise or Sorcery, etc…) so we don't face problem integrating with existing Rails apps we add this engine in.

- posts
	- title
	- publish date
	- revisions (Choosing currently online revision with a "save & publish" button. Can rollback to a desired version)
	- keywords
	- categories
	- content
	- an author (logged user)
- pages
	- title
	- revisions
	- content
- social sharing widgets (twitter, facebook and +1) in posts
- preview mode
- managing the menu (or turning it off) (from partials at first maybe?)

- comments handled by disqus
- some configurations in the env file (with Settingslogic probably)
	- web site title
	- web site url
	- meta description
	- social accounts (facebook, twitter, LinkedIn, etc)
	- API keys for social sharing

- using [Rails cache](http://edgeguides.rubyonrails.org/caching_with_rails.html) for better performance

- runs on Heroku (must disable caching in main_app)


## Installation

## Technology
- Rails 3.2
- RSpec (+ travis CI), Factories, Guard, Capybara
- MySQL & Postgres support (SQLite?)
- Twitter Bootstrap for now...

### Bonbons
- PJAX (pour l'admin, et p-e pour le front)
- BatmanJS (pour l'admin)

## Models
### posts
### posts_revisions
### keywords
### categories


## Ideas for the future

- use [jQuery Waypoints](http://imakewebthings.github.com/jquery-waypoints/) to suggest another article (might be chosen from and?) once the article is read.
	- An example: [See the "recommended story" once you reach the bottom of article](http://www.readwriteweb.com/archives/the_other_1_people_who_still_use_ie6.php)

- plugins
- themes (with Deface)

- easy contact form for an about page
- configurations in the database

- multiple sites with only one intance

## Contribute