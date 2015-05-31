require_relative '../test_config'

class CreatePostTest < MiniTest::Test
  include DatabaseTesting
  def test_will_create_post
    context = OpenStruct.new
    email = 'test@example.com'
    form = CreatePost::Form.new :email => email
    interactor = CreatePost.new context, form
    assert_equal :created, interactor.outcome
    assert_equal email, interactor.output.first.record.email
  end
end
