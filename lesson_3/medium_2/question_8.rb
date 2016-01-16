# question_7.rb

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo)

# The output of this code would be "no". foo returns "yes" regardless of what parameter (if any)
# is passed to it. "yes" is passed to bar and since "yes" does not equate to "no" (i.e. param == "no"
# evaluates to false) then "no" is returned by the ternary operator
