module Vulcanize
  AttributeMissing = Class.new StandardError
  class Form
    def self.attributes
      @attributes ||= {}
    end

    def self.attribute(key, type, required: false, default: nil)
      key = key.to_sym
      attributes[key] = {
        type: type,
        default: default,
        required: required
      }

      define_method key do
        values.fetch(key)
      end

      define_method "#{key}=" do |value|
        if value.nil? or value.empty?
          return values[key] = 0

        end
        values[key] = self.class.attributes[key][:type].forge value do |err|
          errors.add key, err
          value
        end
      end
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
      end
    end

    attr_reader :errors, :values


    def valid?
      errors.empty?
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
