# question_4.rb

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# This block would output the element at inxdex 0 (i.e. '1') then removes the element at index 0
# shifting the other elements down one
# The block would then output the item at index 1 (which would now be '3') and remove item
# shifting the other elements down one.
# At this point it could not move onto the next iteration because there would be no element
# remaining at index 2

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# This block would output the element at inxdex 0 (i.e. '1') then removes the element at index 3
# The block would then output the element at index 1 (i.e. '2') removing the element at index 2
# At this point it could not move onto the next iteration because there would be no element
# remaining at index 2
