class ShowPage
  def initialize(post)
    @post = post
  end

  attr_reader :post

  def title
    "#{post_title} | Scorched Blog"
  end

  def post_title
    post.title
  end

  def post_body
    post.body.html
  end

  def post_email
    post.email
  end

  def published
    post.published? ? post.published_date : 'no'
  end
end
