require_relative './../test_config'

class TitleTest < MiniTest::Test
  def title_string
    'A valid title'
  end

  def title
    Title.new title_string
  end

  def test_is_equal_for_same_title
    assert_equal title, Title.new(title_string)
  end
end
