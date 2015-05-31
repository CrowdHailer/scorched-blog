require_relative '../test_config'

class CreatePostTest < MiniTest::Test
  include DatabaseTesting
  def context
    @context ||= OpenStruct.new
  end

  def email
    @email ||= 'test@example.com'
  end

  def test_will_create_post
    form = CreatePost::Form.new :email => email
    interactor = CreatePost.new context, form

    assert_equal :created, interactor.outcome
    post, = interactor.output
    assert_equal email, post.record.email
  end

  def test_return_invalid_form
    form = CreatePost::Form.new :email => 'bad'
    interactor = CreatePost.new context, form

    assert_equal :invalid_params, interactor.outcome
    form, = interactor.output
    assert_equal 'bad', form.email
  end

end
