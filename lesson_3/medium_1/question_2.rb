# question_2.rb

statement = "The Flintstones Rock!"

hash = {}

statement.chars.uniq.each { |char| hash.store(char, statement.count(char)) }
