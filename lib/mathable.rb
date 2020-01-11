require 'date'

module Mathable

  def create_key
    rand.to_s[2..6]
  end

  def create_offset
    date = find_date.to_i
    date_squared = (date * date)
    date_squared.to_s[-4..-1]
  end

  def find_date
    date = Time.new
    if date.month.to_s.size < 2
      month = "0" + date.month.to_s
    else
      month = date.month.to_s
    end
    new_date = (date.day.to_s + month + date.year.to_s)[0,6]
  end
end
