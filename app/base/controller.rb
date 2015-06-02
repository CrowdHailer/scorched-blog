module ScorchedBlog
  class BaseController < Scorched::Controller
    render_defaults[:layout] = File.expand_path('../templates/layout.erb', __FILE__).to_sym
    render_defaults[:dir] = File.expand_path('../templates', __FILE__)
  end
end
