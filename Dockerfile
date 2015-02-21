# Choose the official Ruby 2.1.2 image as our starting point
FROM ruby:2.1.2

# Run updates
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Set up working directory
ENV APP_HOME /truegm
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Set up gems
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock  
RUN bundle install

# Install foreman
RUN gem install foreman

# Finally, add the rest of our app's code
# (this is done at the end so that changes to our app's code
# don't bust Docker's cache)
ADD . $APP_HOME
