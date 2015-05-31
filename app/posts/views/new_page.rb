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

end
