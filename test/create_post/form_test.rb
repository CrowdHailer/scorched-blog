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

    def test_handles_invalid_email
      form = Form.new :email => 'bad'
      form.email
      assert_includes form.errors.on(:email).first.message, 'valid'
    end

    def test_obtains_publish_state
      form = Form.new :published => '1'
      assert_equal true, form.published
    end

    # def test_obtains_publish_state
    #   form = Form.new :published => 'maybe'
    #   form.published
    #   assert_includes form.errors.on(:published).first.message, 'maybe'
    # end
  end
end
