class Enigma

  attr_reader :key

  def initialize(key)
    @key = key
  end

  def generate_key_hash
    # split number to make an array to reduce over
    @key.reduce({}) do |acc, number|
      require "pry"; binding.pry
    end
  end
end
