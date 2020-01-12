require './lib/enigma'

enigma = Enigma.new

# ARGV is an array that contains the values
# passed by the command line
file = File.open(ARGV[0], "r")
message = file.read
file.close

encrypt = enigma.encrypt(message)

# ARGV is an array that contains the values
# passed by the command line
writing = File.open(ARGV[1], "w")
writing.write(encrypt[:encryption])
writing.close

puts "Created 'encrypted.txt' with the key #{encrypt[:key]} and date #{encrypt[:date]}"
