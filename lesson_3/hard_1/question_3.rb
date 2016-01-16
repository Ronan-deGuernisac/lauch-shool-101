# question_3.rb

# A) This will print
# "one is: one"
# "two is: two"
# "three is: three"
# because 'new' variables are initiated inside the method - this doesn't affect the values of the 
# variables outside of the method

def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

# B) This will print
# "one is: one"
# "two is: two"
# "three is: three"
# Again, 'new' variables are initiated inside the method - this doesn't affect the values of the 
# variables outside of the method

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

# C) This will print
# "one is: two"
# "two is: three"
# "three is: one"
# In this case 'new' variables are not initiated inside the method - so the values of the 
# variables outside of the method are affected (also since using gsub! with the bang)

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"
