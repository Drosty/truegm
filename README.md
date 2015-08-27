# TrueGM

[ ![Codeship Status for Drosty/truegm](https://codeship.io/projects/3e8ac760-2c5b-0132-64c8-1a021f7da059/status)](https://codeship.io/projects/38818)

[![Code Climate](https://codeclimate.com/github/Drosty/truegm.png)](https://codeclimate.com/github/Drosty/truegm) [![Test Coverage](https://codeclimate.com/github/Drosty/truegm/badges/coverage.svg)](https://codeclimate.com/github/Drosty/truegm)

This is a Fantasy Football tracking Site for my Fantasy Football league.

It tracks multiple leagues which has multiple teams.  Each team has a roster of NFL Players and will calculate teams salaries.

Each team has to stay under a certain salary cap.

The roadmap of this application includes importing stats, a forum, projections, trades, free agents, and a UI overhaul (amongst many things)

### Database Project Setup
In order to get the database setup and running run the following commands in this order:


*Note: .env file needs to have the API Key for Fantasy Data set*

``` ruby
bundle exec rake db:create
bundle exec rake db:schema:load
bundle exec rake import:nfl_teams
bundle exec rake import:nfl_schedule
bundle exec rake import:nfl_players

# If you want fake data generated
bundle exec rake generate:fake_salaries
bundle exec rake generate:year_of_fake_stats

# to get real data (this will take a while)
bundle exec rake spotrac:scrape

bundle exec rake db:seed
```
