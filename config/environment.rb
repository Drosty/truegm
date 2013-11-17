# Load the rails application
require File.expand_path('../application', __FILE__)

TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]

# Initialize the rails application
TrueGM::Application.initialize!
