# Monologue: the changelog!

## 0.1.0: initial release

FEATURES

 - Rails mountable engine (fully named spaced)
- tested
- back to basics: few features
- it has post revisions (no UI to choose published revision yet, but it keeps your modification history)
- it has few external dependencies (no Devise or Sorcery, etc…) so we don't face problem integrating with existing Rails app.(Rails mountable engines: dependency nightmare?)
- comments are handled by disqus
- enforcing Rails cache for better performance (only supports file store for now)
- runs on Heroku