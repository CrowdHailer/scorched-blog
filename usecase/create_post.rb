FormBoolean = Typetanic::Boolean :affirmative => ['1'], :negative => ['0']

class CreatePost
  class Form < Vulcanize::Form
    attribute :email, Typetanic::Email
    attribute :published, FormBoolean
  end
end
