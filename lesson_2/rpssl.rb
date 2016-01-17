# rpssl.rb

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

def decide_result(player, computer)
  if win?(player, computer)
    :player
  elsif win?(computer, player)
    :computer
  else
    :tie
  end
end

def display_results(result)
  case result
  when :player then prompt("You won!")
  when :computer then prompt("Computer won!")
  else prompt("It's a tie.")
  end
end

def increment_score(result, scores)
  scores[result] += 1 if result != :tie
  scores
end

def overall_winner?(scores)
  if scores[:player] >= 5
    :player
  elsif scores[:computer] >= 5
    :computer
  else
    false
  end
end

loop do
  prompt("Welcome to #{VALID_CHOICES.map { |_, details| "#{details[:name]}" }.join(', ')}!")
  prompt("First player to score 5 wins!")
  prompt("The choices are: #{VALID_CHOICES.map { |letter, details| "#{letter} for #{details[:name]}" }.join(', ')}")

  scores = { player: 0, computer: 0 }
  loop do
    choice = ''
    loop do
      prompt("Choose one: #{VALID_CHOICES.keys.join(', ')}")
      choice = Kernel.gets().chomp()

      if VALID_CHOICES.keys.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
        prompt("The choices are: #{VALID_CHOICES.map { |letter, details| "#{letter} for #{details[:name]}" }.join(', ')}")
      end
    end

    computer_choice = VALID_CHOICES.keys.sample
    prompt("You chose #{VALID_CHOICES[choice][:name]}, computer chose #{VALID_CHOICES[computer_choice][:name]}")
    result = decide_result(choice, computer_choice)
    display_results(result)
    scores = increment_score(result, scores)
    overall_winner = overall_winner?(scores)

    if overall_winner == :player
      prompt("You won the whole game!")
      prompt("The final score was - You: #{scores[:player]}, Computer #{scores[:computer]}")
    elsif overall_winner == :computer
      prompt("The computer won the whole game!")
      prompt("The final score was - You: #{scores[:player]}, Computer #{scores[:computer]}")
    else
      prompt("The scores are currently - You: #{scores[:player]}, Computer #{scores[:computer]}")
    end

    break if overall_winner
  end

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
