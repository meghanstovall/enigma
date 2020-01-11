require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/enigma'


class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    # @key = @enigma.stubs(:key).returns("02715")
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_equal "02715", @enigma.key
    assert_equal "040895", @enigma.date
  end

  def test_can_create_offset
    assert_equal "1025", @enigma.create_offset
  end

  def test_it_can_create_key_hash
    assert_equal ({a: 02, b: 27, c: 71, d: 15}), @enigma.generate_key_hash
  end

  def test_it_can_create_offset_hash
    assert_equal ({a: 1, b: 0, c: 2, d: 5}), @enigma.generate_offset_hash
  end

  def test_can_create_hash_with_shift_number
    assert_equal ({A: 3, B: 27, C: 73, D: 20}), @enigma.generate_shift_hash
  end

  def test_can_encrypt_message
    assert_equal "keder ohulw!", @enigma.encrypted_message("hello world!")
  end

  def test_can_decrypt_the_message
    assert_equal "hello world!", @enigma.decrypted_message("keder ohulw!")
  end

  def test_can_create_encrypted_hash
    assert_equal ({encryption: "keder ohulw!", key: "02715", date: "040895"}), @enigma.encrypt("hello world!", "02715", "040895")
    assert_equal ({encryption: "keder ohulw!", key: "02715", date: "040895"}), @enigma.encrypt("hello world!", "02715")
    assert_equal ({encryption: "keder ohulw!", key: "02715", date: "040895"}), @enigma.encrypt("hello world!")
  end

  def test_can_create_decrypted_hash
    encrypted = @enigma.encrypt("hello world!", "02715")
    message = encrypted[:encryption]

    assert_equal ({decryption: "hello world!", key: "02715", date: "040895"}), @enigma.decrypt("keder ohulw!", "02715", "040895")
    assert_equal ({decryption: "hello world!", key: "02715", date: "040895"}), @enigma.decrypt(message, "02715")
  end
end
