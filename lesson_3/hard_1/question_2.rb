# question_2.rb

# The result of the last line if code would be to output "{\"a\"=>\"hi there\" }" since using puts would
# convert the original greetings array to a string

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings
