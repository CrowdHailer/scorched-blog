module Vulcanize
  AttributeMissing = Class.new StandardError
  UnknownAttribute = Class.new StandardError

  class Form
    def self.attributes
      @attributes ||= {}
    end

    def self.requires?(attribute_name)
      attribute_hash(attribute_name).fetch(:required)
    end

    def self.default(attribute_name)
      attribute_hash(attribute_name).fetch(:default)
    end

    def self.type(attribute_name)
      attribute_hash(attribute_name).fetch(:type)
    end

    def self.attribute_hash(attribute_name)
      attributes.fetch(attribute_name) do |key|
        raise UnknownAttribute, "No attribute with name '#{key}'"
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

    def self.attribute(attribute_name, type, required: false, default: nil)
      attribute_name = attribute_name.to_sym
      attributes[attribute_name] = {
        type: type,
        default: default,
        required: required
      }

      define_method attribute_name do
        values.fetch(attribute_name)
      end

      define_method "#{attribute_name}=" do |input|
        # Resets to default if input is blank
        if input.nil? or input == ''
          value = attributes[attribute_name][:default]
          # value = default_for attribute_name
          # required? attribute_name
          errors.missing attribute_name if attributes[attribute_name][:required]
          return values[attribute_name] = value
        end

        # Handles error if value invalid
        value = attributes[attribute_name][:type].forge input do |err|
          errors.add attribute_name, err
          return values[attribute_name] = input
        end

        # No error if value is forged
        errors.refresh attribute_name
        values[attribute_name] = value
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

    # def default_for(attribute_name)
    #   attribute(attribute_name)[:default]
    # end

    def attribute(attribute_name)
      attributes[attribute_name]
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
