module ScorchedBlog
  class PostsController < BaseController
    # Include restful controller routes
    include Scorched::Rest

    render_defaults[:dir] = File.expand_path('../views', __FILE__)

    def index
      # form = Archive::Search.new request.GET['search']
      form = OpenStruct.new
      #
      usecase = ListPosts.new(self, form)

      # yield repository instance with search method
      usecase.success do |customers, search|
        render :index
      end

      usecase.invalid_search do |search|
        redirect index_path
      end
    end

    def new
      @view  = NewPage.new
      render :new
    end

    def create
      # params = Post::Create::Form.new request.POST['post']
      #
      # usecase = Post::Create.new(self, form)
      #
      # usecase.created do |post|
      #   redirect show_path(post), 201
      # end
      #
      # usecase.invalid_params do |form|
      #   @create_form = form
      #   render :new
      # end
      redirect '1', 201
    end

    def show(id)
      usecase = ShowPost.new(self, id)

      usecase.found do |post|
        @view = ShowPage.new post
        render :show
      end

      usecase.not_found do |id|
        redirect index_path, 404
      end
    end

    def update(id)
      form = Post::Update::Form.new request.POST['post']

      usecase = Post::Update.new(self, id, form)

      usecase.success do |post|

      end

      usecase.not_found do |id|

      end

      usecase.invalid_params do |post, form|

      end
    end

    def destroy(id)
      response.status = 204
    end

  end
end
