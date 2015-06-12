# require_relative '../test_config'
#
# module Vulcanize
#   class FormTest < MiniTest::Test
#     class StandardForm < ::Vulcanize::Form
#       # attribute :published, Typetanic::Boolean(affirmative: ['1'], negative: ['0'])
#     end
#
#     def test_obtains_published_true
#       form = StandardForm.new(:published => '1')
#       assert_equal true, form.published
#     end
#
#     def test_obtains_published_true_from_string
#       form = StandardForm.new('published' => '1')
#       assert_equal true, form.published
#     end
#
#     def test_form_valid
#       form = StandardForm.new(:published => '1')
#       assert_equal true, form.valid?
#     end
#
#     def test_empty_form_valid
#       form = StandardForm.new(:published => '')
#       assert_equal true, form.valid?
#     end
#
#     def test_obtains_published_false
#       form = StandardForm.new(:published => '0')
#       assert_equal false, form.published
#     end
#
#     def test_invalidates_on_entry
#       form = StandardForm.new(:published => 'random')
#       assert_equal false, form.valid?
#     end
#
#     def test_keeps_invalid_attempt
#       form = StandardForm.new(:published => 'random')
#       assert_equal 'random', form.published
#     end
#
#     def test_keeps_error_for_invalid_published_input
#       form = StandardForm.new(:published => 'random')
#       assert form.errors.on(:published)
#     end
#
#     class DefaultsForm < ::Vulcanize::Form
#       attribute :quantity, Typetanic::Integer, :default => 0
#     end
#
#     def test_returns_0_for_no_value
#       form = DefaultsForm.new
#       assert_equal 0, form.quantity
#     end
#
#     def test_returns_0_for_nil
#       form = DefaultsForm.new(:quantity => nil)
#       assert_equal 0, form.quantity
#     end
#
#     def test_returns_0_for_empty_string
#       form = DefaultsForm.new(:quantity => '')
#       assert_equal 0, form.quantity
#     end
#
#     def test_returns_1
#       form = DefaultsForm.new(:quantity => '1')
#       assert_equal 1, form.quantity
#     end
#
#     class RequiredForm < ::Vulcanize::Form
#       attribute :quantity, Typetanic::Integer, :required => true
#     end
#
#     def test_error_for_missing_quantity
#       form = RequiredForm.new
#       assert_equal false, form.valid?
#       # refute_empty form.errors.on(:quantity)
#     end
#
#     def test_clears_error_for_added_quantity
#       form = RequiredForm.new
#       form.quantity = '3'
#       assert_equal true, form.valid?
#     end
#
#     def test_clears_readds_missing
#       form = RequiredForm.new
#       form.quantity = '3'
#       form.quantity = ''
#       assert_equal false, form.valid?
#     end
#
#   end
# end
