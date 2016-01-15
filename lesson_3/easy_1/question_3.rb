# question_3.rb

advice = "Few things in life are as important as house training your pet dinosaur."

advice.sub('important', 'urgent') # This returns a copy of the string with the first occurence 
                                  # of the word replaced

advice.sub!('important', 'urgent') # This returns the same string rather than a copy with the first
                                   # occurence substituted

# If more than one occurence of the word required changing the following methods could be used

advice.gsub('important', 'urgent') # copy of string

advice.gsub!('important', 'urgent') # same string, word substituted
