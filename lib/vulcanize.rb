module Vulcanize
  AttributeMissing = Class.new StandardError
  class Form
    def self.attributes
      @attributes ||= {}
    end

    def self.attribute(key, type, required: false, default: nil)
      attributes[key.to_sym] = {
        type: type,
        default: default,
        required: required
      }
    end

    def self.defaults
      attributes.each_with_object({}) do |(k, v), h|
        h[k] = v[:default]
      end
    end

    def self.errors
      attributes.each_with_object(Errors.new) do |(k, v), h|
        h[k] = AttributeMissing.new(k) if v[:required]
      end
    end

    def initialize(raw={})
      @errors = self.class.errors
      @values = self.class.defaults
      @raw = raw.each do |k, v|
        public_send "#{k}=", v
        # key = k.to_sym
        # value = InputString.new v, self.class.attributes[key]
        # h[key] = value
      end
    end

    attr_reader :errors, :values

    def published=(value)
      values[:published] = self.class.attributes[:published][:type].forge value do |err|
        errors.add :published, err
        value
      end
    end

    def published
      values[:published]
    end

    def quantity=(value)
      if value.nil? or value.empty?
        return values[:quantity] = 0

      end
      values[:quantity] = self.class.attributes[:quantity][:type].forge value do |err|
        errors.add :quantity, err
        value
      end
    end

    def quantity
      values[:quantity]
    end

    def valid?
      errors.empty?
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
