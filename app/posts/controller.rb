require_relative './views/new_page'
require_relative './views/index_page'
require_relative './views/show_page'

module ScorchedBlog
  class PostsController < BaseController
    include Scorched::Rest
    render_defaults[:dir] = File.expand_path('../templates', __FILE__)

    def index
      # form = Archive::Search.new request.GET['search']
      # form = OpenStruct.new
      # #
      # usecase = ListPosts.new(self, form)
      #
      # # yield repository instance with search method
      # usecase.success do |customers, search|
      #   render :index
      # end
      #
      # usecase.invalid_search do |search|
      #   redirect index_path
      # end
      posts = Posts.new request.GET
      @view = IndexPage.new posts
      render :index
    end

    def new
      @view  = NewPage.new nil
      render :new
    end

    def create
      form =  CreatePost::Form.new request.POST['post']
      interactor = CreatePost.new(self, form)

      interactor.created do |post|
        redirect "/posts/#{post.id}", 302
      end

      interactor.invalid_params do |form|
        response.status = 400
        @view = NewPage.new form
        render :new
      end

    end

    def show(id)
      interactor = ShowPost.new(self, id)

      interactor.found do |post|
        @view = ShowPage.new post
        return render :show
      end

      interactor.not_found do |id|
        redirect index_path, 404
      end
    end

    def edit(id)
      interactor = ShowPost.new(self, id)

      interactor.found do |post|
        @view = EditPage.new post
        return render :edit
      end

      interactor.not_found do |id|
        redirect index_path, 404
      end
    end

    def destroy(id)
      interactor = DestroyPost.new(self, id)

      interactor.success do
        redirect '/posts', 302
      end
    end

  end
end
