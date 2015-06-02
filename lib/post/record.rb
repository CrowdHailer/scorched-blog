require_relative '../random_identifier'
require './lib/title'

module Post
  class Record < Sequel::Model(:posts)
    include RandomIdentifier
    plugin :serialization

    serialize_attributes [Title.method(:dump), Title.method(:load)], :title
    serialize_attributes [Body.method(:dump), Body.method(:load)], :body
    serialize_attributes [Typetanic::Email.method(:dump), Typetanic::Email.method(:load)], :email
  end
end
