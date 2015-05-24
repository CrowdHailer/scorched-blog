# Setup rack enviroment to test unless specified
RACK_ENV = ENV['RACK_ENV'] = 'test' unless defined?(RACK_ENV)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
# Sets up all of load paths that are searched when requiring code
require 'bundler/setup'
# requires all gems for the current runtime enviroment
Bundler.require(:default, RACK_ENV)

# Use a more pleasant reporter and show slowest tests
reporter_options = {color: true, slow_count: 5}
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

# require all test support files
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file}

# Require the application
require_relative '../app/application'

class MyTest < MiniTest::Test
  # include FactoryGirl::Syntax::Methods

  # Ensures all tests are run in a transaction
  # def run(*args, &block)
  #   result = nil
  #   Sequel::Model.db.transaction(:rollback=>:always, :auto_savepoint=>true){result = super}
  #   result
  # end

end
