module ControllerTesting
  def self.included(klass)
    klass.include Rack::Test::Methods
  end

  # NOTE http test methods return response
  # can use as follows
  #
  # assert_ok verb '/url'
  #
  def assert_ok(response=last_response)
    assert response.ok?, "Response was #{last_response.status} not OK"
  end

  # NOTE tests currently set flash before redirection
  # NOTE only works on scorched flash
  def flash
    last_request.env['scorched.flash'][:flash]
  end

end
