require_relative './../test_config'

class BodyTest < MiniTest::Test
  def body_string
    'A valid **body**'
  end

  def body
    Body.new body_string
  end

  def test_shows_as_html
    assert_equal "<p>A valid <strong>body</strong></p>\n", body.html
  end

  def test_show_raw
    assert_equal body_string, body.raw
  end

  def test_raises_error_if_too_short
    assert_raises Body::TooShortError do
      Body.new 'xx'
    end
  end
end
