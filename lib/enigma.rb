require './lib/mathable'

class Enigma
  extend Mathable

  attr_reader :key, :offset, :message

  def initialize(key, offset, message)
    # later on, key and offset will not be arguments
    # instead: @key = mathable method
    #          @offset = mathable method
    @key = key
    @offset = offset
    @alphabet = ("a".."z").to_a << " "
    @message = message.downcase
  end

  def generate_key_hash
    {a: @key[0..1].to_i, b: @key[1..2].to_i, c: @key[2..3].to_i, d: @key[3..4].to_i}
  end

  def generate_offset_hash
    {a: @offset[0].to_i, b: @offset[1].to_i, c: @offset[2].to_i, d: @offset[3].to_i}
  end

  def generate_shift_hash
    key_hash = generate_key_hash
    offset_hash = generate_offset_hash

    key_hash.reduce({}) do |acc, (letter, number)|
      acc[letter.upcase] = number + offset_hash[letter]
      acc
    end
  end

  def encrypted(message, key = @key, offset = @offset)
    {encryption: encrypted_message(message, key, offset), key: key, date: offset}
  end

  def encrypted_message(message, key = @kay, offset = @offset)
    shift_hash = generate_shift_hash

    @message.chars.map.with_index do |letter, index|
      if !@alphabet.include?(letter)
        letter
      elsif index % 4 == 0
        a = @alphabet.rotate(shift_hash[:A])
        a[@alphabet.index(letter)] # before rotate h is at index 7, after rotate k is
      elsif index % 4 == 1
        b = @alphabet.rotate(shift_hash[:B])
        b[@alphabet.index(letter)]
      elsif index % 4 == 2
        c = @alphabet.rotate(shift_hash[:C])
        c[@alphabet.index(letter)]
      elsif index % 4 == 3
        d = @alphabet.rotate(shift_hash[:D])
        d[@alphabet.index(letter)]
      end
    end.join
  end

  def decrypted_message(message, key = @kay, offset = @offset)
    shift_hash = generate_shift_hash

    @message.chars.map.with_index do |letter, index|
      if !@alphabet.include?(letter)
        letter
      elsif index % 4 == 0
        a = @alphabet.rotate(-shift_hash[:A])
        a[@alphabet.index(letter)] # before rotate h is at index 7, after rotate k is
      elsif index % 4 == 1
        b = @alphabet.rotate(-shift_hash[:B])
        b[@alphabet.index(letter)]
      elsif index % 4 == 2
        c = @alphabet.rotate(-shift_hash[:C])
        c[@alphabet.index(letter)]
      elsif index % 4 == 3
        d = @alphabet.rotate(-shift_hash[:D])
        d[@alphabet.index(letter)]
      end
    end.join
  end
end
