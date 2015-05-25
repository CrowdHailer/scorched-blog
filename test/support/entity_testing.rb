# TODO needs to select what you are testing with. Might be overkill
# Note entity does not do coercion
module EnitiyTesting

  def self.included(base)
    base.extend ClassMethods
  end

  def record
    @record ||= OpenStruct.new
  end

  def teardown
    @entry = nil
    @record = nil
    super
  end


  module ClassMethods
    def entry_access(*entries, **options)
      entry_reading *entries, **options
      entry_writing *entries, **options
    end
    
    def entry_reading(*entries, **options)
      entries.each do |entry|
        value = options.fetch(:with) { :test_symbol }
        define_method :"test_can_read_#{entry}" do
          record.send "#{entry}=", value
          assert_equal value, entity.send(entry)
        end
      end
    end

    def entry_writing(*entries, **options)
      entries.each do |entry|
        define_method :"test_can_set_#{entry}" do
          entity.send "#{entry}=", value
          assert_equal value, record.send(entry)
        end
      end
    end
  end

end
