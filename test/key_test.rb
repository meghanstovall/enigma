require './test/test_helper'
require './lib/key'

class KeyTest < Minitest::Test

  def setup
    @key = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_can_generate_random_num
    assert_instance_of String, Key.create_key
  end
end
