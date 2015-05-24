require_relative '../test_config'

module ScorchedBlog
  class HomeControllerTest < MiniTest::Test
    include ControllerTesting

    def app
      HomeController
    end

    def test_home_page_is_availabe
      get '/'
      assert_ok
    end

  end
end
