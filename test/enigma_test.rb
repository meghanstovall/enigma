require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'


class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_equal 02715, @enigma.key
    assert_equal 1025, @enigma
  end
end
