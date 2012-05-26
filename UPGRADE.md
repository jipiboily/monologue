# Upgrade Monologue

## from 0.1.0 to 0.1.1
 - once the gem has been upgraded to 0.1.1, run
 	
 		$ bundle exec rake monologue:install:migrations # this will remove mount point
    $ bundle exec rake db:migrate