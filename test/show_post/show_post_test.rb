require_relative '../test_config'

class ShowPostTest < MiniTest::Test
  include DatabaseTesting
  def context
    @context ||= OpenStruct.new
  end

  def test_will_show_post
    form = CreatePost::Form.new :email => 'test@example.com'
    creation = CreatePost.new context, form
    post = creation.output.first
    interactor = ShowPost.new context, post.id
    assert_equal :found, interactor.outcome
    assert_equal post, interactor.output.first
  end

  def test_will_return_not_found_for_no_post
    interactor = ShowPost.new context, '1'
    assert_equal :not_found, interactor.outcome
    assert_equal '1', interactor.output.first
  end
end
