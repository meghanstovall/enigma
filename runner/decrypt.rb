require './lib/enigma'

enigma = Enigma.new

# ARGV is an array that contains the values
# passed by the command line
file = File.open(ARGV[0], "r")
message = file.read
file.close

decrypt = enigma.decrypt(message, ARGV[2], ARGV[3])

# ARGV is an array that contains the values
# passed by the command line
writing = File.open(ARGV[1], "w")
writing.write(decrypt[:decryption])
writing.close

puts "Created 'decrypt.txt' with the key #{decrypt[:key]} and date #{decrypt[:date]}"
