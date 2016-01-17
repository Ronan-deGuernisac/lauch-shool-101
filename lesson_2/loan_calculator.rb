# loan_calculator.rb

# 1. Determine type of loan (short-term unsecured or long-term secured)
# => a. get loan type (S or L)
# => b. check input loan type is valid
# => c. if loan type invalid ask for type again
# 2. Determine loan amount
# => a. get required loan amount (min/ max dependent on type)
# => b. check amount is valid
# => c. if not valid request amount again
# 3. Determine loan duration
# => a. get required loan duration (min/ max dependent on type)
# => b. check duration is valid
# => c. if not valid request duration again
# 4. Determine APR (based on factors like amount, duration & type)
# 5. Calculate and show monthly repayment amounts
# => Note: formula for monthly payments
# => P = L[c(1 + c)n]/[(1 + c)n - 1]
# => P is monthly payment, L is loan amount, n is number of months, c is interest rate

require 'yaml'
require 'pry'

CONFIG = YAML.load_file('loan_calculator_config.yml')

def prompt(message)
  puts("=> #{message}")
end

def valid_loan_type?(type)
  type.downcase == 's' || type.downcase == 'l'
end

def only_numbers?(string)
  string =~ /[^0-9]/ ? false : true
end

def in_range?(amount, loan_type, val_1, val_2)
  amount.to_i.between?(CONFIG["#{loan_type}"]["#{val_1}"], CONFIG["#{loan_type}"]["#{val_2}"])
end

def invalid_amount(amount, loan_type)
  if !only_numbers?(amount)
    'non_numeric'
  elsif !in_range?(amount, loan_type, 'min_amount', 'max_amount')
    'amount_not_in_range'
  else
    false
  end
end

def invalid_duration(duration, loan_type)
  if !in_range?(duration, loan_type, 'min_duration', 'max_duration')
    'duration_not_in_range'
  else
    false
  end
end

def duration_factor(duration)
  case duration.to_i
  when 1..10
    'duration_factor_1'
  when 11..15
    'duration_factor_2'
  when 16..20
    'duration_factor_3'
  else
    'duration_factor_4'
  end
end

def amount_factor(amount)
  case amount.to_i
  when 1_000..10_000
    'amount_factor_1'
  when 10_001..50_000
    'amount_factor_2'
  when 50_001..100_000
    'amount_factor_3'
  when 100_001..200_000
    'amount_factor_4'
  else
    'amount_factor_5'
  end
end

prompt("What is your name?")

name = gets.chomp

prompt(
  <<-EOT
  "Hi #{name}, welcome to the loan calculator. What kind of loan would you like?
  Select 'S' for short-term unsecured (up to £#{CONFIG['s']['max_amount']} ) or 'L'
  for long-term secured (up to £#{CONFIG['l']['max_amount']})"
  EOT
  )

loan_type = ''
loop do
  loan_type = gets.chomp
  if valid_loan_type?(loan_type)
    break
  else
    prompt("Please select 'S' for short-term unsecured or 'L' for long-term secured")
  end
end

loan_description = CONFIG["#{loan_type}"]['description']
loan_min_amount = CONFIG["#{loan_type}"]['min_amount']
loan_max_amount = CONFIG["#{loan_type}"]['max_amount']
loan_min_duration = CONFIG["#{loan_type}"]['min_duration']
loan_max_duration = CONFIG["#{loan_type}"]['max_duration']

prompt(
  <<-EOT
  You have selected a #{loan_description}
  How much would you like to borrow?
  Please choose an amount between £#{loan_min_amount} and £#{loan_max_amount}.
  Please enter your amount as a whole number without any other characters or
  symbols, e.g. #{loan_min_amount} rather than £1,000.00
  EOT
  )

loan_amount = ''
loop do
  loan_amount = gets.chomp
  amount_validation = invalid_amount(loan_amount, loan_type)
  if amount_validation
    prompt(CONFIG["#{loan_type}"]["#{amount_validation}"])
  else
    break
  end
end

prompt("For what duration in years would you like to borrow £#{loan_amount}?
  Please choose a duration between #{loan_min_duration} and #{loan_max_duration}")

loan_duration = ''
loop do
  loan_duration = gets.chomp
  duration_validation = invalid_duration(loan_duration, loan_type)
  if duration_validation
    prompt(CONFIG["#{loan_type}"]["#{duration_validation}"])
  else
    break
  end
end

monthly_duration = loan_duration.to_i * 12

apr = CONFIG["#{loan_type}"]["#{duration_factor(loan_duration)}"] + CONFIG["#{loan_type}"]["#{amount_factor(loan_amount)}"]

monthly_rate = (apr.to_f / 100) / 12

monthly_repayment = (loan_amount.to_i * (monthly_rate * (1 + monthly_rate)**monthly_duration) / 
  ((1 + monthly_rate)**monthly_duration - 1)).round(2)

total_loan_amount = (monthly_repayment * monthly_duration).round(2)

prompt(
  <<-EOT
  "#{name}, you selected a #{loan_description} 
  for an amount of £#{loan_amount}
  and for a duration of #{loan_duration} years. 
  This loan would have an APR of #{apr}%,
  monthly repayments of #{monthly_repayment} for #{monthly_duration} 
  giving a total loan amount of £#{total_loan_amount}.
  Thank-you for using the loan calculator today."
  EOT
  )
