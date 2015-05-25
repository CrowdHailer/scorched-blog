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
