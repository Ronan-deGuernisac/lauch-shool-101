# question_2.rb

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# We can add Dino by using the shovel operator << or concat, orwe could 
# use insert if we wanted Dino at a particular position in the array

flintstones << "Dino"

flintstones.concat(["Dino"])

flintstones.insert(3, "Dino")
