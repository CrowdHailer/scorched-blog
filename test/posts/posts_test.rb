require_relative '../test_config'

class PostsTest < MiniTest::Test
  include DatabaseTesting
  def apples_post_form
    form = CreatePost::Form.new(
      :email => 'GrannySmith@example.com',
      :title => 'Apples are pretty green'
    )
  end

  def carrots_post_form
    form = CreatePost::Form.new(
      :email => 'Snowman@example.com',
      :title => 'Carrots are good for your eyes'
    )
  end

  def bananas_post_form
    form = CreatePost::Form.new(
      :email => 'Librarian@example.com',
      :title => 'Bananas bananas everywhere'
    )
  end

  def context
    OpenStruct.new
  end

  def setup
    u = CreatePost.new(context, apples_post_form)
    u.created { |post| @apples_post = post}
    u = CreatePost.new(context, carrots_post_form)
    u.created { |post| @carrots_post = post}
    u = CreatePost.new(context, bananas_post_form)
    u.created { |post| @bananas_post = post}
  end

  def apples_post
    @apples_post
  end

  def bananas_post
    @bananas_post
  end

  def carrots_post
    @carrots_post
  end

  def test_orders_by_title
    assert_equal apples_post, Posts.all.first
    assert_equal carrots_post, Posts.all.last
  end

end
