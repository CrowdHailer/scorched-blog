class PostPresenter < SimpleDelegator
  # def initialize(post)
  #   @post = post
  # end

  def published
    __getobj__.published?
  end

  def errors
    Vulcanize::Errors.new
  end
end
class EditPage
  def initialize(post)
    # hash = post.record.values
    # hash.delete(:id)
    # hash.delete(:published_date)
    # form = CreatePost::Form.new(hash)
    @form = PostPresenter.new post
  end

  attr_reader :form

  def title
    'New Post | Scorched Blog'
  end

  def email_value
    form.email if form
  end

  def email_error
    errors.on(:email) if form
  end

  def title_value
    form.title if form
  end

  def title_error
    errors.on(:title) if form
  end

  def body_value
    form.body if form
  end

  def body_error
    errors.on(:body) if form
  end

  def published?
    form && form.published
  end

  private

  def errors
    form.errors
  end

end
