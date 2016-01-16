# question_8.rb

def titleize(string)
  string = string.split.each { |s| s.capitalize! }.join(" ")
  string
end

string = "this is just some string of words"

string = titleize(string)

puts string
