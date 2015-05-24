require_relative '../test_config'

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

    def test_can_create_post
      post '/'
      assert_created
    end

    def test_can_delete_post
      delete '/1'
      assert_no_content
    end

  end
end
