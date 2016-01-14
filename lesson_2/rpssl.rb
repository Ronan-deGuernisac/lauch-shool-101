# rpssl.rb

require 'pry'

VALID_CHOICES = {
  'r' => { name: 'rock', beats: %w(s l) },
  'p' => { name: 'paper', beats: %w(r k) },
  's' => { name: 'scissors', beats: %w(p l) },
  'k' => { name: 'Spock', beats: %w(s r) },
  'l' => { name: 'lizard', beats: %w(p k) }
}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  VALID_CHOICES[first][:beats].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie.")
  end
end

loop do
  choice = ''
  loop do
    prompt("The choices are: #{VALID_CHOICES.map { |k, v| "#{k} for #{v[:name]}" }.join(', ')}")
    prompt("Choose one: #{VALID_CHOICES.keys.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.keys.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.keys.sample

  prompt("You chose #{VALID_CHOICES[choice][:name]}, computer chose #{VALID_CHOICES[computer_choice][:name]}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
