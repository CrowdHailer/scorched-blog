require_relative '../test_config'

module Post
  class RecordTest < MiniTest::Test
    include DatabaseTesting

    # def required_attributes
    #   {
    #     :email => 'test@examle.com'
    #   }
    # end
    # def attributes(**overwrites)
    #   required_attributes.merge overwrites
    # end

    def test_requires_email
      assert_raises Sequel::NotNullConstraintViolation do
        Record.create
      end
    end

    def test_it_can_be_published
      record = Record.new :published => true
      assert_equal true, record.published
    end

    def test_it_can_have_email
      email = Typetanic::Email.new 'test@example.com'
      record = Record.new :email => email
      assert_equal email, record.email
    end

    def test_it_can_have_title
      title = Title.new 'The Post'
      record = Record.new :title => title
      assert_equal title, record.title
    end

    def test_it_can_have_body
      body = Body.new 'lots of lovel text in the post'
      record = Record.new :body => body
      assert_equal body, record.body
    end

    def test_it_can_have_published_date
      record = Record.new :published_date => DateTime.new(2015, 5, 30)
      assert_equal DateTime.new(2015, 5, 30), record.published_date
    end

    def test_is_always_empty
      # Used to check the database transactions are working
      assert Record.empty?
    end
  end
end
