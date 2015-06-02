require File.expand_path("../../config/boot.rb", __FILE__)

require File.expand_path('../base/controller.rb', __FILE__)
Dir[File.expand_path('../*/controller.rb', __FILE__)].each { |file| require file}

module ScorchedBlog
  class App < BaseController

    controller '/posts', PostsController
    # Load mounted controllers before catchall root controller
    controller '/', HomeController

    after :status => 404 do
      response.body = render :'404', :layout => :error
    end

    error do
      if RACK_ENV == 'production'
        response.status = 500
        response.body = render :'500'
      end
    end
  end
end
