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

  private

  def value=(value)
    @value = value
  end

end
