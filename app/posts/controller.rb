require_relative './views/new_page'
require_relative './views/index_page'

module ScorchedBlog
  class PostsController < BaseController
    # Include restful controller routes
    include Scorched::Rest

    render_defaults[:dir] = File.expand_path('../templates', __FILE__)

    def index
      # form = Archive::Search.new request.GET['search']
      form = OpenStruct.new
      #
      usecase = ListPosts.new(self, form)

      # yield repository instance with search method
      usecase.success do |customers, search|
        @view = IndexPage.new
        render :index
      end

      usecase.invalid_search do |search|
        redirect index_path
      end
    end

    def new
      @view  = NewPage.new OpenStruct.new
      render :new
    end

    def create
      ap request.POST['post']
      form =  CreatePost::Form.new request.POST['post']
      usecase = CreatePost.new(self, form)

      usecase.created do |post|
        redirect "/posts/#{post.id}", 302
      end

      usecase.invalid_params do |form|
        response.status = 400
        @view = NewPage.new form
        render :new
      end

    end

    def show(id)
      # usecase = ShowPost.new(self, id)
      #
      # usecase.found do |post|
      #   @view = ShowPage.new post
      #   render :show
      # end
      #
      # usecase.not_found do |id|
      #   redirect index_path, 404
      # end
      'hello'
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
