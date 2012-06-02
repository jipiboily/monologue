# Upgrade Monologue

## from 0.1.0 to 0.1.1
 - once the gem has been upgraded to 0.1.1, run
 	
1. $`bundle exec rake monologue:install:migrations # this will remove mount point`
2. $`bundle exec rake db:migrate`

If you made changes in Monologue's post views, you will want to change all `@revision.url` to `@revision.full_url` and `revision.url` to `revision.full_url`.