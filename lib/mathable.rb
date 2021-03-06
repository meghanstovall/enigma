require 'date'

module Mathable

  def self.create_key
    rand.to_s[2..6]
  end

  def self.create_offset(date = find_date)
    date_squared = (date.to_i * date.to_i)
    date_squared.to_s[-4..-1]
  end

  def self.find_date
    date = Time.now.strftime("%d%m%y")
  end
end
