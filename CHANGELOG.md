# Monologue: the changelog!
(for upgrade informations, see UPGRADE.md)

## 0.2.0.beta
- add tags (or labels)
- add a UI to manage current user's account
- add RSS icon
- add social icons
- add Gauge (http://gaug.es) for analytics
- there is now a sidebar: you can put the latest posts, tweets or whatever you want! Kinda simple system but efficient enough for now.
- front page articles are now more cleverly truncated
- a few Deface hooks (data-monologue attribute) were added to the admin layout (for the menu)
- update admin UI with newest Twitter Boostrap (v2.1.1)
- visual look has been slightly updated (hey, designers, want to help on Monologue next design? You're "hired"!)
- deprecate ruby 1.8
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