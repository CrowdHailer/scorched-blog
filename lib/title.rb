class Title
  TooLongError = Class.new(Typetanic::Invalid)
  TooShortError = Class.new(Typetanic::Invalid)
  InvalidCharactersError = Class.new(Typetanic::Invalid)
  
  extend Typetanic::Forge
  extend Typetanic::Stash

  def self.load(string)
    new(string)
  end

  def initialize(value)
    self.value = value
  end

  def value
    @value
  end

  def ==(other)
    other.is_a?(self.class) && value == other.value
  end

  def to_s
    value
  end
  alias_method :to_str, :to_s
  alias_method :dump, :to_s

  private

  def value=(value)
    formated = value.strip.capitalize
    raise TooLongError, 'is too long' unless formated.length <= 70
    raise TooShortError, 'is too short' unless formated.length >= 3
    raise InvalidCharactersError, 'contains invalid charachters' unless formated[/^[a-z0-9\s]+$/i]
    @value = formated
  end

end
