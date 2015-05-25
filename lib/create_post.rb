class Typetanic::Email
  def self.forge(raw)
    begin
      new(raw)
      # TODO Typetanic Invalid should inherit off argument error
    rescue Typetanic::Email::Invalid => err
      yield err
    end
  end
end

module Typetanic
  Invalid = Class.new(ArgumentError)
end

class Typetanic::Boolean
  UnknownRepresentation = Class.new(Typetanic::Invalid)
  def self.affirmative
    ['1']
  end

  def self.negative
    ['0']
  end

  def is_affirmative(raw)
    affirmative.include? raw
  end

  def is_negative()
    negative.include? raw
  end

  def self.forge(raw)
    return true if is_affirmative raw
    return false if is_negative raw
    yield UnknownRepresentation.new raw
  end
end

class CreatePost
  class Form
    def initialize(raw)
      @raw = raw
      @errors = {}
    end

    attr_reader :raw, :errors

    def email
      Typetanic::Email.forge raw.fetch(:email) do |err|
        @errors[:email] = err
      end
    end

    def published
      Typetanic::Boolean.forge raw.fetch(:published) do |err|
        @errors[:published] = err
      end
    end

  end

end

# class Form
#   attribute :email, Typetanic::Email
# end
