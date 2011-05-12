# Load the rails application
require File.expand_path('../application', __FILE__)
#require 'my_date_override'

Rails::Initializer.run do |config|
config.gem "mongo_mapper"
end
# Initialize the rails application
SmallApp::Application.initialize!



