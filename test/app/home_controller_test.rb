require_relative '../test_config'

module ScorchedBlog
  class HomeControllerTest < MiniTest::Test
    include ControllerTesting
    # Probably should be part of ControllerTesting
    include Capybara::DSL

    def app
      HomeController
    end

    def setup
      Capybara.app = app
    end

    def test_home_page_is_availabe_capybara
      visit '/'
      # ap page.methods - Object.methods
      assert_title 'Scorched Blog'

      # ap page.title
      # ap page.status_code
      # ap page.html
      within 'main' do |selection|
        find('h1').assert_text 'He'
      end
      # assert_title
      # assert_ok
    end

    def test_home_page_is_available_rack_test
      response = get '/'
      html = Nokogiri::HTML(response.body) { |config| config.strict }
      ap html.css('head > title').text
      ap html.css('body h1')
    end

  end
end
