require './test/test_helper'
require './lib/offset'

class OffsetTest < Minitest::Test

  def setup
    @offset = Offset.new
  end

  def test_it_exists
    assert_instance_of Offset, @offset
  end

  def test_can_find_current_date
    assert_equal "110120", Offset.find_date
  end

  def test_can_use_date_to_create_offset
    assert_equal "4400", Offset.create_offset
  end
end
