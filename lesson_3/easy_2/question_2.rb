# question_2.rb

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

total_age = 0
ages.each_value { |value| total_age = total_age + value }

puts total_age
