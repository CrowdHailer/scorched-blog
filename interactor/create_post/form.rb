class CreatePost
  class Form < Vulcanize::Form
    attribute :email, Typetanic::Email, :required => true
    attribute :published, FormBoolean
    attribute :title, Title
    attribute :body, Body, :default => false
  end
end
