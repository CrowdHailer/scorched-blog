require_relative './views/welcome_page.rb'

module ScorchedBlog
  class HomeController < BaseController
    render_defaults[:dir] = File.expand_path('../templates', __FILE__)

    get '/' do
      @view = WelcomePage.new
      render :welcome
    end

  end
end
