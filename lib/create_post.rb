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

  def self.is_affirmative?(raw)
    affirmative.include? raw
  end

  def self.is_negative?(raw)
    negative.include? raw
  end

  def self.forge(raw)
    return true if is_affirmative? raw
    return false if is_negative? raw
    yield UnknownRepresentation.new raw
  end
end

class Typetanic::String

end
# Form object should have a :default => option
# Form object should have a :from => display_name tp handle JSON responses
# Form object should have a :required => true
# Form object should not try to coerce empty string or nil unless required
# Form object should encourage nilObject use
# Form needs Standard Boolean, String, Integer, Float, DateTime
# Check out virtus Array and Hash they might need to be included in awesomeness
# general nesting structure checkout useuful music batch
# there should be a true type that is invalid when false for check terms and conditions

h = Hash.new { |hash, key| key }
h.merge!(
  String => Typetanic::String
)

module Titan
  class Errors < ::Hash
    def self.new
      # TODO test that you get a diff array instance each time
      super do
        []
      end
    end

    def add(attribute, error)
      attribute = attribute.to_sym
      self[attribute] += [error]
    end

    def on(attribute)
      self[attribute.to_sym]
    end
  end
  # TODO doesnt need to handle arrays as forge should return only one error.
end

class CreatePost
  class Form
    def initialize(raw)
      @raw = raw
      @errors = Titan::Errors.new
    end

    attr_reader :raw, :errors

    def email
      Typetanic::Email.forge raw.fetch(:email) do |err|
        @errors.add __method__, err
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
