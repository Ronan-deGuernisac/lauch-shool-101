# question_5.rb

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break if !is_a_number?(word)
  end
  return true
end

# To fix this we could add an if/ else condition to check that there are four parts to the ip address
# by checking the length of the array resulting from the split method
# We could also return false conditions both from the first clause of our if/ else condition and from
# is_a_number

def is_a_number?(w)
  w =~ /\A\d+\z/
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  if dot_separated_words.length != 4 
    return false
  else
    while dot_separated_words.size > 0 do
      word = dot_separated_words.pop
      if !is_a_number?(word)
        return false
      end
    end
    true
  end
end

ip = "10.4.5.11"

puts dot_separated_ip_address?(ip)
