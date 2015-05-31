FormBoolean = Typetanic::Boolean :affirmative => ['1'], :negative => ['0']

class CreatePost
  class Form < Vulcanize::Form
    attribute :email, Typetanic::Email, :required => true
    attribute :published, FormBoolean
  end
end
