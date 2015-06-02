class FormBoolean
  extend Typetanic::Forge
  def self.new(value)
    value == 'on'
  end
  # TODO still might make sense to handle invalid values here
end
