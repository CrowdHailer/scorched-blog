# FormBoolean = Typetanic::Boolean :affirmative => ['1'], :negative => ['0']

class CreatePost < AllSystems::Interactor
  require_relative './create_post/form'

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
      # post = Posts.create form
      # send emails
      # report_created post
    else
      # report error if wanted
      report_invalid_params form
    end
  end
end
