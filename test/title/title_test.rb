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

  def test_clears_white_space
    assert_equal title, Title.new("  #{title_string}")
  end

  def test_capitalizes_first_word
    assert_equal title, Title.new('a valid title')
  end

  def test_shows_as_a_string
    assert_equal title_string, title.to_s
  end

  def test_shows_as_a_strict_string
    assert_equal title_string, title.to_str
  end
end
