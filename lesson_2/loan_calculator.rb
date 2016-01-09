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

CONFIG = YAML.load_file('loan_calculator_config.yml')

def prompt(message)
  puts("=> #{message}")
end

def valid_loan_type?(type)
  type.downcase == 's' || type.downcase == 'l' ? true : false
end

def only_numbers?(string)
  string =~ /[^0-9]/ ? false : true
end

def in_range?(amount, val_1, val_2)
  amount.to_i.between?(CONFIG["#{@loan_type}"]["#{val_1}"], CONFIG["#{@loan_type}"]["#{val_2}"])
end

def valid_loan_amount?(amount)
  if !only_numbers?(amount)
    @error_type = 'non_numeric'
    return false
  elsif !in_range?(amount, 'min_amount', 'max_amount')
    @error_type = 'amount_not_in_range'
    return false
  else
    true
  end
end

def valid_loan_duration?(duration)
  if !in_range?(duration, 'min_duration', 'max_duration')
    @error_type = 'duration_not_in_range'
    return false
  else
    true
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

prompt("Hi #{name}, welcome to the loan calculator. What kind of loan would you like?
  Select 'S' for short-term unsecured (up to £#{CONFIG['s']['max_amount']} ) or 'L'
  for long-term secured (up to £#{CONFIG['l']['max_amount']})")

@loan_type = ''
loop do
  @loan_type = gets.chomp
  if valid_loan_type?(@loan_type)
    break
  else
    prompt("Please select 'S' for short-term unsecured or 'L' for long-term secured")
  end
end

loan_description = CONFIG["#{@loan_type}"]['description']
loan_min_amount = CONFIG["#{@loan_type}"]['min_amount']
loan_max_amount = CONFIG["#{@loan_type}"]['max_amount']
loan_min_duration = CONFIG["#{@loan_type}"]['min_duration']
loan_max_duration = CONFIG["#{@loan_type}"]['max_duration']

prompt("You have selected a #{loan_description}
  How much would you like to borrow?
  Please choose an amount between £#{loan_min_amount} and £#{loan_max_amount}.
  Please enter your amount as a whole number without any other characters or
  symbols, e.g. #{loan_min_amount} rather than £1,000.00")

loan_amount = ''
@error_type = ''
loop do
  loan_amount = gets.chomp
  if valid_loan_amount?(loan_amount)
    break
  else
    prompt(CONFIG["#{@loan_type}"]["#{@error_type}"])
  end
end

prompt("For what duration in years would you like to borrow £#{loan_amount}?
  Please choose a duration between #{loan_min_duration} and #{loan_max_duration}")

loan_duration = ''
loop do
  loan_duration = gets.chomp
  if valid_loan_duration?(loan_duration)
    break
  else
    prompt(CONFIG["#{@loan_type}"]["#{@error_type}"])
  end
end

monthly_duration = loan_duration.to_i * 12

apr = CONFIG["#{@loan_type}"]["#{duration_factor(loan_duration)}"] + CONFIG["#{@loan_type}"]["#{amount_factor(loan_amount)}"]

monthly_rate = (apr.to_f / 100) / 12

monthly_repayment = (loan_amount.to_i * (monthly_rate * (1 + monthly_rate)**monthly_duration) / ((1 + monthly_rate)**monthly_duration - 1)).round(2)

total_loan_amount = (monthly_repayment * monthly_duration).round(2)

prompt("#{name}, you selected a #{loan_description} for an amount of £#{loan_amount}
  and for a duration of #{loan_duration} years. This loan would have an APR of #{apr},
  monthly repayments of #{monthly_repayment} for #{monthly_duration} giving a total loan
  amount of £#{total_loan_amount}.
  Thank-you for using the loan calculator today.")
