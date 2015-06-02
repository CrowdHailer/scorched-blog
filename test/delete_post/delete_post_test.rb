require_relative '../test_config'

class ShowPostTest < MiniTest::Test
  include DatabaseTesting
  def context
    @context ||= OpenStruct.new
  end

  def test_will_destroy_existing_post
    form = CreatePost::Form.new :email => 'test@example.com'
    creation = CreatePost.new context, form
    post = creation.output.first
    interactor = DestroyPost.new context, post.id
    assert_equal :success, interactor.outcome
  end

  def test_will_success_for_no_post_assumed_already_deleted
    interactor = DestroyPost.new context, '1'
    assert_equal :success, interactor.outcome
  end
end
