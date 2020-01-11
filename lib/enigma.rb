require './lib/mathable'

class Enigma
  extend Mathable

  attr_reader :key, :date, :message

  def initialize(message)
    # later on, key will not be arguments
    # instead: @key = mathable method
    @key = "02715"
    #@date = Mathable.find_date
    @date = "040895"
    @alphabet = ("a".."z").to_a << " "
    @message = message.downcase
  end

  def create_offset
    Mathable.offset("040895")
  end

  def generate_key_hash
    {a: @key[0..1].to_i, b: @key[1..2].to_i, c: @key[2..3].to_i, d: @key[3..4].to_i}
  end

  def generate_offset_hash
    offset = create_offset
    {a: offset[0].to_i, b: offset[1].to_i, c: offset[2].to_i, d: offset[3].to_i}
  end

  def generate_shift_hash
    key_hash = generate_key_hash
    offset_hash = generate_offset_hash

    key_hash.reduce({}) do |acc, (letter, number)|
      acc[letter.upcase] = number + offset_hash[letter]
      acc
    end
  end

  def encrypted(message, key = @key, date = @date)
    {encryption: encrypted_message(message, key, date), key: key, date: date}
  end

  def encrypted_message(message, key = @kay, offset = create_offset)
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

  def decrypted(message, key = @key, date = @date)
    {decryption: decrypted_message(message, key, date), key: key, date: @date}
  end

  def decrypted_message(message, key = @kay, offset = create_offset)
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
