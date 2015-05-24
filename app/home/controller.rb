
module ScorchedBlog
  class HomeController < BaseController
    # render_defaults[:dir] += '/home'

    get '/' do
      'hello world'
      # render :index
    end

  end
end
