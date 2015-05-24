# Require the complete application
require File.expand_path("../app/application.rb", __FILE__)

# Mount the application to rack
run ScorchedBlog::App
