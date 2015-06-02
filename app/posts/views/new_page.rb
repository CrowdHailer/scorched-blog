class NewPage
  def initialize(form)
    @form = form
  end

  attr_reader :form

  def title
    'New Post | Scorched Blog'
  end

  def email_value
    form.email if form
  end

  def email_error
    form.errors.on(:email) if form
  end

  def title_value
    form.title if form
  end

  def title_error
    form.errors.on(:title) if form
  end

  def body_value
    form.body if form
  end

  def body_error
    form.errors.on(:body) if form
  end

  def published?
    form && form.published
  end

end
