require './lib/mathable'

class Enigma
  extend Mathable

  attr_reader :key, :date, :alphabet

  def initialize
    @key = Mathable.create_key
    @date = Mathable.find_date
    @alphabet = ("a".."z").to_a << " "
  end

  def create_offset(date = @date)
    Mathable.create_offset(date)
  end

  def generate_key_hash(key = @key)
    {a: key[0..1].to_i, b: key[1..2].to_i, c: key[2..3].to_i, d: key[3..4].to_i}
  end

  def generate_offset_hash(offset = create_offset)
    {a: offset[0].to_i, b: offset[1].to_i, c: offset[2].to_i, d: offset[3].to_i}
  end

  def generate_shift_hash(key = @key, offset = create_offset)
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(offset)

    key_hash.reduce({}) do |acc, (letter, number)|
      acc[letter.upcase] = number + offset_hash[letter]
      acc
    end
  end

  def encrypt(message, key = @key, date = @date)
    offset = create_offset(date)
    {encryption: encrypted_message(message, key, offset), key: key, date: date}
  end

  def encrypted_message(message, key = @key, offset = create_offset)
    shift_hash = generate_shift_hash(key, offset)
    message.chars.map.with_index do |letter, index|
      if !@alphabet.include?(letter)
        letter
      elsif index % 4 == 0
        shift(shift_hash[:A], letter)
      elsif index % 4 == 1
        shift(shift_hash[:B], letter)
      elsif index % 4 == 2
        shift(shift_hash[:C], letter)
      elsif index % 4 == 3
        shift(shift_hash[:D], letter)
      end
    end.join
  end


  def decrypt(message, key = @key, date = @date)
    offset = create_offset(date)
    {decryption: decrypted_message(message, key, offset), key: key, date: date}
  end

  def decrypted_message(message, key = @key, offset = create_offset)
    shift_hash = generate_shift_hash(key, offset)
    message.chars.map.with_index do |letter, index|
      if !@alphabet.include?(letter)
        letter
      elsif index % 4 == 0
        shift(-shift_hash[:A], letter)
      elsif index % 4 == 1
        shift(-shift_hash[:B], letter)
      elsif index % 4 == 2
        shift(-shift_hash[:C], letter)
      elsif index % 4 == 3
        shift(-shift_hash[:D], letter)
      end
    end.join
  end

  def shift(rotate_by, letter)
    rotated_alphabet = @alphabet.rotate(rotate_by)
    rotated_alphabet[@alphabet.index(letter)] # before rotate h is at index 7, after rotate k is
  end

  # def crack(message, date = @date)
  #   #create method to find the key
  #   #key = find_key
  #   {decryption: cracked_message(message, date), date: date, key: key}
  # end
  #
  # def cracked_message(message, date = @date)
  #   reverse_message = message.split("").reverse()
  #
  #   reverse_message.map.with_index do |letter, index|
  #     if index % 4 == 0
  #       shift(-19, letter)
  #     elsif index % 4 == 1
  #       shift(-27, letter)
  #     elsif index % 4 == 2
  #       shift(-3, letter)
  #     elsif index % 4 == 3
  #       shift(-20, letter)
  #     end
  #   end.reverse.join
  # end
end
