class Enigma

  attr_reader :key, :offset

  def initialize(key, offset)
    @key = key
    @offset = offset
  end

  def generate_key_hash
    {a: @key[0..1].to_i, b: @key[1..2].to_i, c: @key[2..3].to_i, d: @key[3..4].to_i}
  end

  def generate_offset_hash
    {a: @offset[0].to_i, b: @offset[1].to_i, c: @offset[2].to_i, d: @offset[3].to_i}
  end
end
