require_relative '../test_config'

module Post
  class RecordTest < MiniTest::Test
    include DatabaseTesting
    
    def test_it_can_be_published
      record = Record.create :published => true
      assert_equal true, record.published
    end

    def test_is_always_empty
      assert Record.empty?
    end
  end
end
