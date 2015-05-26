module Vulcanize
  class Form
    def self.attributes
      @attributes ||= {}
    end

    def self.attribute(key, type, **options)
      attributes[key] = type
    end

    def initialize(raw={})
      @errors = Errors.new
      @raw = raw
    end

    attr_reader :errors

    def published
      self.class.attributes[:published].forge @raw[:published] do |err|
        errors.add :published, err
        nil
      end
    end

    def quantity
      return 0 if @raw[:quantity].nil? or @raw[:quantity].empty?
      self.class.attributes[:quantity].forge @raw[:quantity] do |err|
        errors.add :quantity, err
        nil
      end
    end

    def valid?
      published
    end
  end

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
