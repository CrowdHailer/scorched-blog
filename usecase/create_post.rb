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
    [:created]
  end

  attr_reader :context, :form

  def go!
    record = Post::Record.new :email => form.email
    report_created Post.new(record)
  end
end
