require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'


class EnigmaTest < Minitest::Test

  def setup
    @encrypt = Enigma.new("02715", "1025", "HEllo world!")
    @decrypt = Enigma.new("02715", "1025", "keder ohulw!")
  end

  def test_it_exists
    assert_instance_of Enigma, @encrypt
  end

  def test_it_has_attributes
    assert_equal "02715", @encrypt.key
    assert_equal "1025", @encrypt.offset
    assert_equal "hello world!", @encrypt.message
  end

  def test_it_can_create_key_hash
    assert_equal ({a: 02, b: 27, c: 71, d: 15}), @encrypt.generate_key_hash
  end

  def test_it_can_create_key_hash
    assert_equal ({a: 1, b: 0, c: 2, d: 5}), @encrypt.generate_offset_hash
  end

  def test_can_create_hash_with_shift_number
    assert_equal ({A: 3, B: 27, C: 73, D: 20}), @encrypt.generate_shift_hash
  end

  def test_can_encrypt_message
    assert_equal "keder ohulw!", @encrypt.encrypted_message("hello world!")
  end

  def test_can_decrypt_the_message
    assert_equal "hello world!", @decrypt.decrypt
  end
end
