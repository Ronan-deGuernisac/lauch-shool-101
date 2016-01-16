# question_1.rb

# I would expect this to do nothing and return nil since the the variable 'greeting' was not
# set as the if statement did not evaluate to false.
# If we had used 'if true' instead 'greeting' would still have done nothing since we are not
# asking it to output anything but it would have returned "hello world" rather thn nil since
# it would have been set to this value

if false
  greeting = "hello world"
end

greeting
