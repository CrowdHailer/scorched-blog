class CreatePost
  class Form < Vulcanize::Form
    attribute :email, Typetanic::Email, :required => true
    attribute :published, FormBoolean, :default => false
    attribute :title, Title
    attribute :body, Body
  end
end
