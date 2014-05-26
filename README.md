# TrueGM

[![Coverage Status](https://coveralls.io/repos/Drosty/truegm/badge.png?branch=master)](https://coveralls.io/r/Drosty/truegm?branch=master)

This is a Fantasy Football tracking Site for my Fantasy Football league.

It tracks multiple leagues which has multiple teams.  Each team has a roster of NFL Players and will calculate teams salaries.

Each team has to stay under a certain salary cap.

The roadmap of this application includes importing stats, a forum, projections, trades, free agents, and a UI overhaul (amongst many things)

### Database Project Setup
In order to get the database setup and running run the following commands in this order:

``` ruby
bundle exec rake db:create
bundle exec rake db:schema:load
bundle exec rake import_data:offense
bundle exec rake db:seed
```
