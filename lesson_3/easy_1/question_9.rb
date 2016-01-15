# question_9.rb

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

# There are two elements to this
# 1. Removing all the key value pairs except for "Barney" => 2
# 2. Changing the resulting hash into an array

# For the first part we could use keep_if or select and for the second part flatten

flintstones = flintstones.keep_if { |k, v| k == "Barney" }.flatten

flintstones = flintstones.select { |k, v| k == "Barney" }.flatten