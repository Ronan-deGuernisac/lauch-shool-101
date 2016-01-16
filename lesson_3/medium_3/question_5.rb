# question_5.rb

def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end

# The unnecessary duplication could be removed by using a ternary operator

def color_valid(color)
  color == "blue" || color == "green" ? true : false
end
