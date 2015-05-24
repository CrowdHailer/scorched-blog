module ControllerTesting
  def self.included(klass)
    klass.include Rack::Test::Methods
  end

  # NOTE http test methods return response
  # can use as follows
  #
  # assert_ok verb '/url'
  #

  # test a given response had an ok status
  def assert_ok(response=last_response)
    assert response.ok?, "Response was #{last_response.status} not OK"
  end

  # test a response returned as created
  def assert_created(response=last_response)
    assert_equal 201, response.status, "Response was #{last_response.status} not Created"
  end

  # test a response returned with no content
  def assert_no_content(response=last_response)
    assert_equal 204, response.status, "Response was #{last_response.status} not No Content"
  end

  # NOTE tests currently set flash before redirection
  # NOTE only works on scorched flash
  def flash
    last_request.env['scorched.flash'][:flash]
  end

end
