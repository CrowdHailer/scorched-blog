module ScorchedBlog
  class PostsController < BaseController
    # Include restful controller routes
    include Scorched::Rest

    render_defaults[:dir] = File.expand_path('../views', __FILE__)

    def index
      render :index
    end
  end
end
