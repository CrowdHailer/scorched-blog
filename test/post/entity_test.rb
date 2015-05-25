require_relative '../test_config'

module Post
  class EntityTest < MiniTest::Test
    include EnitiyTesting

    def entity
      @entity ||= Entity.new record
    end

    def test_can_be_published
      record.published = true
      assert entity.published?
    end

  end
end
