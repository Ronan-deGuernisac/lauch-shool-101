# 21_game.rb

SUITS = [
  { name: "Spades", symbol: "\u2660" },
  { name: "Hearts", symbol: "\u2665" },
  { name: "Clubs", symbol: "\u2663" },
  { name: "Diamonds", symbol: "\u2666" }
]

CARDS = [
  { name: "One", symbol: "1", points: 1 },
  { name: "Two", symbol: "2", points: 2 },
  { name: "Three", symbol: "3", points: 3 },
  { name: "Four", symbol: "4", points: 4 },
  { name: "Five", symbol: "5", points: 5 },
  { name: "Six", symbol: "6", points: 6 },
  { name: "Seven", symbol: "7", points: 7 },
  { name: "Eight", symbol: "8", points: 8 },
  { name: "Nine", symbol: "9", points: 9 },
  { name: "Ten", symbol: "10", points: 10 },
  { name: "Jack", symbol: "J", points: 10 },
  { name: "Queen", symbol: "Q", points: 10 },
  { name: "King", symbol: "K", points: 10 },
  { name: "Ace", symbol: "A", points: 11 }
]

HIGHEST_SCORE = 21
DEALER_STICK_SCORE = 17
PLAYER_OPTIONS = { 'h' => 'Hit', 's' => 'Stick' }

def prompt(msg)
  puts "=> #{msg}"
end

def initialise_deck(deck)
  SUITS.each do |suit|
    CARDS.each do |card|
      deck << {
        suit_name: suit[:name], suit_symbol: suit[:symbol],
        card_name: card[:name], card_symbol: card[:symbol], points: card[:points]
      }
      deck.shuffle!
    end
  end
end

def deal_initial_cards(deck, hands, scores)
  2.times do
    hands.each { |player, hand| deal_card(deck, hand, scores, player, false) }
  end
end

def deal_card(deck, hand, scores, current_player, announce=true)
  card = deck.shift
  hand << card
  update_score(hand, scores, current_player)
  announce_card(card) if announce
end

def update_score(hand, scores, current_player)
  scores[current_player] = calculate_score(hand)
end

def show_cards(hand, hidden_card=false)
  cards = []
  hand.each { |card| cards << "#{card[:card_symbol]}#{card[:suit_symbol]}" }
  cards[0] = "??" if hidden_card
  cards.join("  ")
end

def show_score(score, hidden_card=false)
  score >= 10 ? score = "#{score}" : score = " #{score}"
  score = "??" if hidden_card
  score
end

def show_table(hands, scores, dealer_hidden=true)
  system 'clear' or system 'cls'
  puts "-----------------------------------------"
  puts " PLAYER | SCORE  | CARDS"
  puts "-----------------------------------------"
  puts " Player |   #{show_score(scores['Player'])}   | #{show_cards(hands['Player'])}"
  puts " Dealer |   #{show_score(scores['Dealer'], dealer_hidden)}   | #{show_cards(hands['Dealer'], dealer_hidden)}"
  puts "-----------------------------------------"
end

def busted?(score)
  score > HIGHEST_SCORE
end

def calculate_score(hand)
  score = 0
  hand.each { |card| score += card[:points] }
  score = reduce_aces(hand, score) if score > HIGHEST_SCORE && ace_count(hand) > 0
  score
end

def ace_count(hand)
  ace_count = 0
  hand.each { |card| ace_count += 1 if card[:card_symbol] == "A" }
  ace_count
end

def reduce_aces(hand, score)
  aces = ace_count(hand)
  while score > HIGHEST_SCORE && aces > 0
    score -= 10
    aces -= 1
  end
  score
end

def dealer_hit_or_stick(score)
  score >= DEALER_STICK_SCORE ? "s" : "h"
end

def valid_choice?(choice)
  PLAYER_OPTIONS.key?(choice)
end

def player_choice
  hit_or_stick = ""
  loop do
    prompt "Hit or Stick? (type H or S)"
    hit_or_stick = gets.chomp
    break unless !valid_choice?(hit_or_stick.downcase)
    prompt "Sorry, that's not a valid choice"
  end
  hit_or_stick
end

def dealer_choice(score)
  sleep(2)
  dealer_hit_or_stick(score)
end

def announce_choice(player, choice)
  prompt "#{player} chose to #{PLAYER_OPTIONS[choice]}"
  sleep(1)
end

def announce_card(card)
  prompt "Card dealt was a #{card[:card_name]} of #{card[:suit_name]}"
  sleep(2)
end

def announce_bust(hands, scores, current_player)
  show_table(hands, scores, false)
  prompt "#{current_player} busted!"
end

def play_turn(deck, hands, scores, current_player)
  loop do
    hit_or_stick = case current_player
                   when 'Dealer'
                     show_table(hands, scores, false)
                     dealer_choice(scores[current_player])
                   when 'Player'
                     show_table(hands, scores)
                     player_choice
                   end
    announce_choice(current_player, hit_or_stick)
    deal_card(deck, hands[current_player], scores, current_player) if hit_or_stick.downcase == 'h'
    break if busted?(scores[current_player]) || hit_or_stick.downcase == 's'
  end
end

def declare_winner(scores)
  if busted?(scores['Player'])
    prompt 'Dealer wins'
  elsif busted?(scores['Dealer'])
    prompt 'Player wins'
  else
    prompt decide_winner(scores)
  end
end

def decide_winner(scores)
  if scores['Player'] == scores['Dealer']
    "It's a tie"
  elsif scores['Player'] > scores['Dealer']
    "Player wins!"
  else
    "Dealer wins!"
  end
end

def play_again?
  gets.chomp.downcase.start_with?('y')
end

loop do
  deck = []
  initialise_deck(deck)
  hands = { 'Player' => [], 'Dealer' => [] }
  scores = { 'Player' => 0, 'Dealer' => 0 }
  deal_initial_cards(deck, hands, scores)

  play_turn(deck, hands, scores, 'Player')

  if busted?(scores['Player'])
    announce_bust(hands, scores, 'Player')
  else
    play_turn(deck, hands, scores, 'Dealer')
    announce_bust(hands, scores, 'Dealer') if busted?(scores['Dealer'])
  end
  declare_winner(scores)

  prompt "Play again?"
  break unless play_again?
end

prompt "Thanks for playing 21!"
