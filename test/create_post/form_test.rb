require_relative '../test_config'

class CreatePost
  class FormTest < MiniTest::Test
    def example_email
      @email ||= Typetanic::Email.new 'test@example.com'
    end

    # def title_input
    #   'A nice Title'
    # end

    def test_obtains_email
      form = Form.new :email => 'test@example.com'
      assert_equal example_email, form.email
    end

    def test_is_valid_with_email
      form = Form.new :email => 'test@example.com'
      assert_equal true, form.valid?
    end

    def test_handles_invalid_email
      form = Form.new :email => 'bad'
      assert_includes form.errors.on(:email).message, 'is not a valid email'
    end

    def test_requires_email
      form = Form.new :email => ''
      assert_equal true, form.errors.missing?(:email)
    end

    def test_obtains_title
      title_input = 'A nice title'
      form = Form.new :title => title_input
      assert_equal Title.new(title_input), form.title
    end

    def test_handles_invalid_title
      title_input = 'A <dangerous> title'
      form = Form.new :title => title_input
      assert_equal 'contains invalid charachters', form.errors.on(:title).message
    end

    def test_obtains_body
      body_input = 'Some informative content'
      form = Form.new :body => body_input
      assert_equal body_input, form.body.raw
    end

    def test_obtains_publish_state
      form = Form.new :published => 'on'
      assert_equal true, form.published
    end
    #
    # def test_handles_invalid_published_state
    #   form = Form.new :published => 'maybe'
    #   form.published
    #   assert_includes form.errors.on(:published).message, 'maybe'
    # end
  end
end
