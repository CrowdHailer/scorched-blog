require_relative '../test_config'

module Vulcanize
  class AttributesTest < MiniTest::Test
    # Class Methods
    def test_attributed_starts_empty
      klass = Class.new Form
      assert_empty klass.attributes
    end

    def test_can_add_attribute
      klass = Class.new Form
      klass.attribute :email, :TYPE
      assert klass.attributes.has_key?(:email), "Keys = '#{klass.attributes.keys.join(', ')}'"
    end

    def test_can_add_attribute_as_string
      klass = Class.new Form
      klass.attribute 'email', :TYPE
      assert klass.attributes.has_key?(:email), "Keys = '#{klass.attributes.keys.join(', ')}'"
    end

    def test_saves_type_to_attrbiute
      klass = Class.new Form
      klass.attribute :email, :TYPE
      assert_equal :TYPE, klass.attributes[:email][:type]
    end

    def test_saves_default_to_nil
      klass = Class.new Form
      klass.attribute :email, :TYPE
      assert_nil klass.attributes[:email][:default]
    end

    def test_saves_required_to_false
      klass = Class.new Form
      klass.attribute :email, :TYPE
      assert_equal false, klass.attributes[:email][:required]
    end

    def test_saves_over_write_required_state
      klass = Class.new Form
      klass.attribute :email, :TYPE, required: true
      assert_equal true, klass.attributes[:email][:required]
    end

    def test_saves_over_write_default
      klass = Class.new Form
      klass.attribute :email, :TYPE, default: :symbol
      assert_equal :symbol, klass.attributes[:email][:default]
    end

    def test_requires_attribute_is_true
      klass = Class.new Form
      klass.attribute :email, :TYPE, required: true
      assert_equal true, klass.requires?(:email)
    end

    def test_requires_attribute_is_false
      klass = Class.new Form
      klass.attribute :email, :TYPE
      assert_equal false, klass.requires?(:email)
    end

    def test_raises_error_when_getting_required_status_of_unknown_attribute_name
      klass = Class.new Form
      assert_raises(Vulcanize::UnknownAttribute) { klass.requires? :email }
    end

    def test_makes_available_default
      klass = Class.new Form
      klass.attribute :email, :TYPE, default: :symbol
      assert_equal :symbol, klass.default(:email)
    end

    def test_raises_error_when_getting_default_of_unknown_attribute_name
      klass = Class.new Form
      assert_raises(Vulcanize::UnknownAttribute) { klass.default :email }
    end

    def test_makes_available_type
      klass = Class.new Form
      klass.attribute :email, :TYPE
      assert_equal :TYPE, klass.type(:email)
    end

    def test_raises_error_when_getting_type_of_unknown_attribute_name
      klass = Class.new Form
      assert_raises(Vulcanize::UnknownAttribute) { klass.type :email }
    end
  end
end
