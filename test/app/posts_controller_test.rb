require_relative '../test_config'

class DummyInteractor < AllSystems::Interactor
  def initialize(*args)

  end

  def result
    [:created, Post.new(Post::Record.new)]
  end

  def outcomes
    [:created, :invalid_params]
  end
end
# Instead of a dummy class use a dummy method
# CreatePost.stub :new, CreatePost.dummy do
#   # blah
# end
# This would need to test if it is safe to use a dummy
# def self.dummy
#   ALL_SYSTEMS_ENV ||= RACK_ENV
#   ALL_SYSTEMS_ENV == 'test'
#   raise UnsafeEnvError
# end

module ScorchedBlog
  class PostsControllerTest < MiniTest::Test
    include ControllerTesting

    def app
      PostsController
    end

    def test_home_page_is_availabe
      get '/'
      assert_ok
    end

    # def test_show_page_has_posts_title
    #   # uses oStruct record
    #   post = Post.new()
    #   # In tests monkey patch in posts
    #   # post = Post.published
    #   FindPost.stub :result, [:success, post] do
    #     visit('/')
    #   end
    #   within('.header') do
    #     has_content post.email
    #   end
    # end

    def test_can_create_post
      post '/', {:post => {:email => 'test@example.com'}}
      # assert_created
    end

    def test_handles_invalid_params
      CreatePost.stub :new, DummyInteractor.new do
        post '/', {:post => {:email => 'bad'}}
      end
      ap last_response.status
      # assert_created
    end

    def test_can_delete_post
      delete '/1'
      assert_no_content
    end

  end
end
