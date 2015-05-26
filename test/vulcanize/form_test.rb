require_relative '../test_config'

module Vulcanize
  class FormTest < MiniTest::Test
    class StandardForm < ::Vulcanize::Form
      attribute :published, Typetanic::Boolean(affirmative: ['1'], negative: ['0'])
    end

    def test_obtains_published_true
      form = StandardForm.new(:published => '1')
      assert_equal true, form.published
    end

    def test_obtains_published_true_from_string
      form = StandardForm.new('published' => '1')
      assert_equal true, form.published
    end

    def test_form_valid
      form = StandardForm.new(:published => '1')
      assert_equal true, form.valid?
    end

    def test_obtains_published_false
      form = StandardForm.new(:published => '0')
      assert_equal false, form.published
    end

    def test_keeps_error_for_invalid_published_input
      form = StandardForm.new(:published => 'random')
      form.valid?
      refute_empty form.errors.on(:published)
    end

    def test_returns_nil_for_invalid_value
      form = StandardForm.new(:published => 'random')
      assert_nil form.published
    end

    class DefaultsForm < ::Vulcanize::Form
      attribute :quantity, Typetanic::Integer, :default => 0
    end

    def test_returns_0_for_no_value
      form = DefaultsForm.new
      assert_equal 0, form.quantity
    end

    def test_returns_0_for_nil
      form = DefaultsForm.new(:quantity => nil)
      assert_equal 0, form.quantity
    end

    def test_returns_0_for_empty_string
      form = DefaultsForm.new(:quantity => '')
      assert_equal 0, form.quantity
    end

    def test_returns_1
      form = DefaultsForm.new(:quantity => '1')
      assert_equal 1, form.quantity
    end

  end
end
