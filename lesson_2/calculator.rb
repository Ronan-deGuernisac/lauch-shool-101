# calculator.rb

# 1. ask the user for two numbers
# 2. asks the user for an operation to perform
# 3. perform the operation on the two numbers
# 4. output the result

# answer = Kernel.gets()
# Kernel.puts(answer)

require 'yaml'
@messages = YAML.load_file('calculator_messages_english.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  if num == '0'
    return true
  elsif num.to_i && num.to_f == 0
    return false
  else
    return true
  end
end

def operation_to_message(op)
  operation = case op
              when '1'
                @messages['adding']
              when '2'
                @messages['subtracting']
              when '3'
                @messages['multiplying']
              when '4'
                @messages['dividing']
              end
  operation
end

def valid_language?(lang)
  lang.downcase() == 'e' || lang.downcase() == 'f' ? true : false
end

prompt(@messages['language'])

language = ''
loop do
  language = Kernel.gets().chomp()

  if valid_language?(language)
    if language.downcase() == 'f'
      @messages = YAML.load_file('calculator_messages_french.yml')
    end
    break
  else
    prompt(@messages['valid_language'])
  end
end

prompt(@messages['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(@messages['valid_name'])
  else
    break
  end
end

prompt("#{@messages['hi']} #{name}")

loop do # main loop
  number1 = ''
  loop do
    prompt(@messages['request_first_number'])
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt(@messages['valid_number'])
    end
  end

  number2 = ''
  loop do
    prompt(@messages['request_second_number'])
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(@messages['valid_number'])
    end
  end

  prompt(@messages['operation_long'])

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(@messages['operation_short'])
    end
  end

  prompt("#{operation_to_message(operator)} #{@messages['operation_output']}")

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("#{@messages['result']} #{result}")

  prompt(@messages['calculate_again'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?(@messages['again'])
end

prompt(@messages['thank_you'])
