require_relative '../random_identifier'

module Post
  class Record < Sequel::Model(:posts)
    include RandomIdentifier
  end
end
