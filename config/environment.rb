# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SmallApp::Application.initialize!


config.frameworks -= [:active_record]

config.gem "mongo_mapper"

