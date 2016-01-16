# question_5.rb

def factors(number)
  dividend = number
  divisors = []
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
  divisors
end

# We could use a while loop instead of the begin end until construct

def factors(number)
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

# The purpose of number % dividend == 0 is to ensure only factors of number are added to the
# array - i.e. the modulus of number and dividend is zero

# The purpose of the second to last line 'divisors' is to return the populated array
