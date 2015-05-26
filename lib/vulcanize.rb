module Vulcanize
  class Form
    def self.attributes
      @attributes ||= {}
    end

    def self.attribute(key, type, **options)
      attributes[key] = {type: type}.merge! options
    end

    def initialize(raw={})
      @errors = Errors.new
      @raw = raw.each_with_object({}) do |(k, v), h|
        key = k.to_sym
        value = InputString.new v, self.class.attributes[key]
        h[key] = value
      end
    end

    attr_reader :errors

    def published
      # return nil unless self.class.attributes.fetch(:published, nil)
      # self.class.attributes.fetch(:published, {})[:type].forge @raw[:published] do |err|
      #   errors.add :published, err
      #   nil
      # end
      @raw[:published].coerce do |err|
        errors.add :published, err
        nil
      end
    end

    def quantity
      raw_input = @raw.fetch(:quantity, InputString.new(nil, self.class.attributes[__method__]))
      ap raw_input
      return raw_input.default if raw_input.blank?
      raw_input.coerce do |err|
        errors.add :quantity, err
        nil
      end
      # return @raw[:quantity].default if @raw[:quantity].blank?
      # self.class.attributes[:quantity][:type].forge @raw[:quantity] do |err|
      #   errors.add :quantity, err
      #   nil
      # end
    end

    def valid?
      published
      # quantity
    end
  end

  class InputString
    def initialize(raw, **options)
      # TODO clean white space
      @raw = raw
      @options = options
    end

    attr_reader :raw, :options

    def blank?
      raw.nil? or raw.empty?
    end

    def default
      options.fetch(:default) {  }
    end

    def type
      options.fetch(:type)
    end

    def required
      options.fetch(:required) { false }
    end

    def coerce(&block)
      type.forge raw, &block
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
