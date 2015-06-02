class Title
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

  private

  def value=(value)
    @value = value.strip.capitalize
  end

end
