module ScorchedBlog
  class BaseController < Scorched::Controller
    render_defaults[:layout] = File.expand_path('../templates/layout.erb', __FILE__).to_sym
  end
end
