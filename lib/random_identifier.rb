module RandomIdentifier
  def initialize(*args, &block)
    super
    self.id ||= SecureRandom.urlsafe_base64
  end
end
