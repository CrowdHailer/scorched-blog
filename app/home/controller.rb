
module ScorchedBlog
  class HomeController < BaseController
    render_defaults[:dir] = File.expand_path('../views', __FILE__)

    get '/' do
      render :welcome
    end

  end
end
