# question_1.rb

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers  # would expect this to output 1, 2, 2 and 3 as a list since puts outputs
              # a string and uniq is non-destructive. If uniq! had been used instead 
              # would expect 1, 2 and 3 to be output as a list