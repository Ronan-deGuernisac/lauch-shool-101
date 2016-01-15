# question_7.rb

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

eval(how_deep) # This returns 42 - the orignal number 2 with 8 added to it 5 times
