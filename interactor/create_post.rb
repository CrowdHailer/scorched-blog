# FormBoolean = Typetanic::Boolean :affirmative => ['1'], :negative => ['0']
class FormBoolean
  extend Typetanic::Forge
  def self.new(value)
    value == 'on'
  end
  # TODO still might make sense to handle invalid values here
end

class CreatePost < AllSystems::Interactor
  class Form < Vulcanize::Form
    attribute :email, Typetanic::Email, :required => true
    attribute :published, FormBoolean
    attribute :title, Title
    attribute :body, Body, :default => false
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
      # post = Posts.create form
      # send emails
      # report_created post
    else
      # report error if wanted
      report_invalid_params form
    end
  end
end
