require_relative '../test_config'

module Post
  class RecordTest < MiniTest::Test
    def test_it_can_be_published
      record = Record.create :published => true
      assert_equal true, record.published
    end
  end
end
