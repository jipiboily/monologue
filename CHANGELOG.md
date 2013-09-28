# Monologue: the changelog!
(for upgrade information, see UPGRADE.md)
## 0.4.0
 - Rails 4 only
 - Change of syntax for configuration. Please use Monologue::Config instead of the old Monologue module

## 0.3.0
 - move the user_id column from Monologue::PostRevision to Monologue::Post.
 - Portuguese, Italian and Spanish translations were added! You can now use Monologue in either French, English, Romanian, Portuguese, Italian and Spanish
 - Remove revisions
 - Preview using Ajax
 - User management
 - bug fixes & cleanup

## 0.2.0
 - all the previsous features from 0.2.0.beta
 - Romanian translations were added, thanks to [mixandgo](https://github.com/mixandgo). You can now use Monologue in either French, English or Romanian!
 - few bug fixes

## 0.2.0.beta
- **IMPORTANT: add cache management config and UI. [Please review the new config options](https://github.com/jipiboily/monologue/wiki/Configure-Monologue's-cache)!**
- first extension available: [monologue-markdown](https://github.com/jipiboily/monologue-markdown)
- add tags
- add a UI to manage current user's account (welcome in 2012, you can now change your password!)
- add RSS icon
- add social icons
- add [Gaug.es](http://gaug.es) tags
- there is now a sidebar: you can put the latest posts, tweets or whatever you want! Kinda simple system but efficient enough for now. Included: tag cloud, categories (tag), latest posts and tweets.
- front page articles are now more cleverly truncated
- a few [Deface](https://github.com/spree/deface) hooks (data-monologue attribute) were added to the admin layout (for the menu)
- update admin UI with newest Twitter Boostrap (v2.1.1)
- visual look has been slightly updated **(Hey, designers, want to help on Monologue next design? You're "hired"!)**  [Preview](http://screencast.com/t/6Ua49p2TdqP)
- add support for Twitter Cards (https://dev.twitter.com/docs/cards)
- deprecate Ruby 1.8 (you should really upgrade, 2.0 is about to get real and Rails 4 won't run on Ruby 1.8)
- lot of bug fixed

## 0.1.3
- a bug fix due to the new URL pattern

## 0.1.2
- there was a regression with RSS feed URLs. It is now fixed and there is a test assuring this bug will never come back. It is part of the new 0.1.2 version. Sorry!

## 0.1.1

- the "comment" link in admin now works as expected and shows all comments from your Disqus account;
- changed URL pattern, now without mount point (say "/" or "/blog") (fix for https://github.com/jipiboily/monologue/issues/64 by https://github.com/jipiboily/monologue/issues/59);
- you can now use your main_app layout with Monologue (https://github.com/jipiboily/monologue/issues/54) (use config: Monologue.layout. See wiki for more information/example);
- added Open Graph tags;
- posts published with a date in the future are not displayed anymore;
- multiple bug fixes;


## 0.1.0: initial release (May 5, 2012)

FEATURES

 - Rails mountable engine (fully named spaced)
 - tested
 - back to basics: few features
 - it has post revisions (no UI to choose published revision yet, but it keeps your modification history)
 - it has few external dependencies (no Devise or Sorcery, etc…) so we don't face problem integrating with existing Rails app.(Rails mountable engines: dependency nightmare?)
 - comments are handled by disqus
 - enforcing Rails cache for better performance (only supports file store for now)
 - runs on Heroku