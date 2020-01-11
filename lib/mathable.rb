# require 'date'
#
# module Mathable
#
#   def self.create_key
#     rand.to_s[2..6]
#   end
#
#   def self.offset(date)
#     if date == nil
#       date = find_date
#     end
#     date_squared = (date.to_i * date.to_i)
#     date_squared.to_s[-4..-1]
#   end
#
#   def self.find_date
#     date = Time.new
#     if date.month.to_s.size < 2
#       month = "0" + date.month.to_s
#     else
#       month = date.month.to_s
#     end
#     new_date = (date.day.to_s + month + date.year.to_s)[0,6]
#   end
# end
