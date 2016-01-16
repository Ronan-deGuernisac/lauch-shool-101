# question_5.rb

# The following code above will output 34 since the method does not alter the orignal variable

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
