class Body
  TooShortError = Class.new(Typetanic::Invalid)
  Renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

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

  def html
    Renderer.render(value)
  end

  def raw
    value
  end
  alias_method :to_s, :raw
  alias_method :to_str, :raw
  alias_method :dump, :raw

  private

  def value=(value)
    raise TooShortError, 'is too short' unless value.length >= 10
    @value = value
  end
end
