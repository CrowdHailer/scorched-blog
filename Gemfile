source "https://rubygems.org"

# Set the Ruby version to be used
ruby '2.2.0'

# Loads the enviroment variables from a hidden .env file
# NB. the .env file must not be checked into source control
gem 'dotenv'

# Improves the quality of output printed to the console
gem 'awesome_print'

# Web server
gem 'thin'

# Automatic reloading of Rack based applications
gem 'shotgun'

# Application framework
gem 'scorched'

# Ruby compilation of .scss/.sass files to browser compatible .css files
gem 'sass'

group :test do
  gem 'rack-test', :require => 'rack/test'
  gem 'minitest', :require => 'minitest/autorun'
  gem 'minitest-reporters'
end
