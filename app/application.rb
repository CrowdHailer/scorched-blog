# Load the boot file which runs all setup required before server start
require File.expand_path("../../config/boot.rb", __FILE__)

# Load all controllers
require File.expand_path('../_base_controller.rb', __FILE__)
Dir[File.expand_path('../**/controller.rb', __FILE__)].each { |file| require file}

def production?
  RACK_ENV == 'production'
end

module ScorchedBlog
  class App < BaseController

    # Load further controllers before final root mounted controller
    controller '/posts', PostsController
    controller '/', HomeController

    # If application does not find resource render helpful 404 page
    after :status => 404 do
      response.body = render :'errors/404'
    end

    # If there is an unhandled error in production render helpful 500 page
    error do
      if production?
        response.status = 500
        response.body = render :'errors/500'
      end
    end
  end
end
