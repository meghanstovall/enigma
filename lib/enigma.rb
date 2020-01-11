require './lib/mathable'

class Enigma
  extend Mathable

  attr_reader :key, :offset, :message_array

  def initialize(key, offset, message)
    # later on, key and offset will not be arguments
    # instead: @key = mathable method
    #          @offset = mathable method
    @key = key
    @offset = offset
    @letters = ("a".."z").to_a << " "
    @message_array = message.split("")
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

  def encrypt

  end

  def find_new_letter_index(letter)
    shift_hash = generate_shift_hash

    #count will always be zero unluss there is a loop
    count = 0
    if count.even? && count % 4 == 0 #A
      num = shift_num_larger_or_equal(count, shift_hash[:A])
      if num == nil
        shift_num = count + shift_hash[:A]
      else
        shift_num = num
      end
    elsif count.odd? && (count + 1) % 4 == 0 #D
      num = shift_num_larger_or_equal(count, shift_hash[:D])
      if num == nil
        shift_num = count + shift_hash[:D]
      else
        shift_num = num
      end
    elsif count.even? #C
      num = shift_num_larger_or_equal(count, shift_hash[:C])
      if num == nil
        shift_num = count + shift_hash[:C]
      else
        shift_num = num
      end
    elsif count.odd? #B
      num = shift_num_larger_or_equal(count, shift_hash[:B])
      if num == nil
        shift_num = count + shift_hash[:B]
      else
        shift_num = num
      end
    end
    count += 0
    @message_array.shift
    shift_num
  end

  def shift_num_larger_or_equal(letter_index, shift_hash_value)
    if shift_hash_value == 27
      27
    elsif shift_hash_value > 27
      (letter_index / 27.0).to_i
    end
  end
end
