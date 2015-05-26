module Vulcanize
  AttributeMissing = Class.new StandardError
  class Form
    def self.attributes
      @attributes ||= {}
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

      define_method "#{key}=" do |input|
        # Resets to default if input is blank
        if input.nil? or input == ''
          value = attributes[key][:default]
          # value = default_for key
          # required? key
          errors.missing key if attributes[key][:required]
          return values[key] = value
        end

        # Handles error if value invalid
        value = attributes[key][:type].forge input do |err|
          errors.add key, err
          return values[key] = input
        end

        # No error if value is forged
        errors.refresh key
        values[key] = value
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

    def attributes
      self.class.attributes
    end

    # def default_for(key)
    #   attribute(key)[:default]
    # end

    def attribute(key)
      attributes[key]
    end

    def valid?
      errors.empty?
    end
  end

  class Errors < ::Hash
    # def missing?(attribute)
    #   on(attribute)is_a? AttributeMissing
    # end
    #
    # def invalid?(attribute)
    #   on(attribute) && !missing?(attribute)
    # end

    def missing(attribute)
      err = AttributeMissing.new attribute
      add attribute, err
    end

    def add(attribute, error)
      attribute = attribute.to_sym
      self[attribute.to_sym] = error
    end

    def on(attribute)
      self[attribute.to_sym]
    end

    def refresh(attribute)
      delete attribute.to_sym
    end
  end
end
