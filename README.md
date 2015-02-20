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
bundle exec rake import:nfl_players
bundle exec rake import:nfl_schedule

# If you want fake data generated
bundle exec rake generate:fake_salaries
bundle exec rake generate:year_of_fake_stats

bundle exec rake db:seed
```


### Steps for Docker local development installation

#### install virtualbox
```
brew tap caskroom/cask
brew install brew-cask
brew cask install virtualbox
```

#### install boot2docker
```
brew install boot2docker
boot2docker init
boot2docker start
$(boot2docker shellinit)
```

Add the EXPORTS that are listed in the output to either your .zshrc or bashrc file.  Then reload your terminal or  ```source .zshrc or .bashrc```

#### install fig
```
brew install fig
```

### Running Docker
After all the things are installed you can get the environment up and running with the following command. This will install and run all the services locally (this might take a while since it will download and install all the things)
```
fig up
```

### Environment Setup Commands with Fig

``` ruby
fig run web rake db:create
fig run web rake db:schema:load
fig run web rake import:nfl_teams
fig run web rake import:nfl_players
fig run web rake import:nfl_schedule

# If you want fake data generated
fig run web rake generate:fake_salaries
fig run web rake generate:year_of_fake_stats

fig run web rake db:seed
```
