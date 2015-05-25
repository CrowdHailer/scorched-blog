module Post
  def self.new(*args, &block)
    Entity.new(*args, &block)
  end
end
Dir[File.join(
  File.dirname(__FILE__),
  File.basename(__FILE__, '.*'),
  '*.rb')
].each {|file| require file }
# Might make sense to use this as we expect a record and an entity
# require_relative './post/record'
# require_relative './post/entity'
