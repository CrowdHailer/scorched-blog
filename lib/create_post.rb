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

  end

end

# class Form
#   attribute :email, Typetanic::Email
# end
