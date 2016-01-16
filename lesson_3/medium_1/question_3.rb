# question_3.rb

puts "the value of 40 + 2 is " + (40 + 2)

# This would give an error because we are trying to concatenate a String and a Fixnum
# One way of fixing this would be to convert the Fixnum to a String
# Another way of fixing it would be to use string interpolation

puts "the value of 40 + 2 is " + (40 + 2).to_s # Convert to String
puts "the value of 40 + 2 is #{(40 + 2)}" # String interpolation
