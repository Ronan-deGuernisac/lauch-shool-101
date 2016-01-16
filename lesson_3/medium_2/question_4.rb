# question_4.rb

sentence = "Humpty Dumpty sat on a wall."

sentence = sentence.gsub(".","").split.reverse.join(" ").concat(".")

puts sentence
