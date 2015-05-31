
module ScorchedBlog
  class HomeController < BaseController
    require_relative './views/welcome_page.rb'
    render_defaults[:dir] = File.expand_path('../templates', __FILE__)

    get '/' do
      @view = WelcomePage.new
      render :welcome
    end

  end
end
