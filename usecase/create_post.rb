FormBoolean = Typetanic::Boolean :affirmative => ['1'], :negative => ['0']

class CreatePost < AllSystems::Interactor
  class Form < Vulcanize::Form
    attribute :email, Typetanic::Email, :required => true
    attribute :published, FormBoolean
  end

  def initialize(context, form)
    @context = context
    @form = form
  end

  def outcomes
    [:created, :invalid_params]
  end

  attr_reader :context, :form

  def go!
    if form.valid?
      record = Post::Record.new :email => form.email
      report_created Post.new(record)
    else
      report_invalid_params form
    end
  end
end
