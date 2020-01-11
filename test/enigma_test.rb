require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'


class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new("02715", "1025")
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_equal "02715", @enigma.key
    assert_equal "1025", @enigma.offset
  end

  def test_it_can_create_key_hash
    assert_equal ({a: 02, b: 27, c: 71, d: 15}), @enigma.generate_key_hash
  end

  def test_it_can_create_key_hash
    assert_equal ({a: 1, b: 0, c: 2, d: 5}), @enigma.generate_offset_hash
  end

  def test_can_create_hash_with_shift_number
    assert_equal ({A: 3, B: 27, C: 73, D: 20}), @enigma.generate_shift_hash
  end
end
