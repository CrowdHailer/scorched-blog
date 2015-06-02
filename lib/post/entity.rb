module Post
  class Entity < Errol::Entity
    boolean_accessor :published
    entry_accessor :email, :title, :body
  end
end
