# question_2.rb

# ! and ? both sometimes appear at the end of methods:
# ! is often used for methods that are destructive
# ? is often for methods which return a boolean
# This behaviour should not be assumed, however

# ! can be used as a comparison operator
# ? can be used in as a ternary operator

# 1. != is used as a comparison operator for 'does not equal'. It should be used when 
# to want to check that one value is not identical to another

# 2. putting ! before something like !user_name reverse the boolean value (e.g. from true to false).
# This can be used to check if a variable has a value

# 3. putting ! after something like words.uniq! would depend one what the method was and what
# the element you were appending the method to was. In this example, if words is an array
# words.uniq! returns the same array but with any duplicate values removed.

# 4. putting ? before something does not have any function and may produce a syntax error

# 5. putting ? after something depends on that that thing is. If it is a valid ending to a method
# name then the method will be invoked, e.g. empty? on a string will return true if the string has a length of zero.
# Just putting ? after something does not have a function in itself and may cause an
# undefined method error.

# 6. putting !! before something like !!user_name will reverse the boolean value of that thing twice.
# for example if user_name = false then !user_name will equate to true and !!user_name will equate to false
