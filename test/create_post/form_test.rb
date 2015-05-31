require_relative '../test_config'

class CreatePost
  class FormTest < MiniTest::Test
    def example_email
      @email ||= Typetanic::Email.new 'test@example.com'
    end

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

    def test_obtains_publish_state
      form = Form.new :published => '1'
      assert_equal true, form.published
    end

    def test_handles_invalid_published_state
      form = Form.new :published => 'maybe'
      form.published
      assert_includes form.errors.on(:published).message, 'maybe'
    end
  end
end
