# question_10.rb

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# We can use each_with_index to populate the hash

hash = {}
flintstones.each_with_index { |val, idx| hash[val] = idx }

