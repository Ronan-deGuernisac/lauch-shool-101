# 21_game.rb

CARD_SUITS = [
  { suit_name: "Spades", suit_symbol: "\u2660" },
  { suit_name: "Hearts", suit_symbol: "\u2665" },
  { suit_name: "Clubs", suit_symbol: "\u2663" },
  { suit_name: "Diamonds", suit_symbol: "\u2666" }
]

CARD_VALUES = [
  { value_name: "One", value_symbol: "1", points: 1 },
  { value_name: "Two", value_symbol: "2", points: 2 },
  { value_name: "Three", value_symbol: "3", points: 3 },
  { value_name: "Four", value_symbol: "4", points: 4 },
  { value_name: "Five", value_symbol: "5", points: 5 },
  { value_name: "Six", value_symbol: "6", points: 6 },
  { value_name: "Seven", value_symbol: "7", points: 7 },
  { value_name: "Eight", value_symbol: "8", points: 8 },
  { value_name: "Nine", value_symbol: "9", points: 9 },
  { value_name: "Ten", value_symbol: "10", points: 10 },
  { value_name: "Jack", value_symbol: "J", points: 10 },
  { value_name: "Queen", value_symbol: "Q", points: 10 },
  { value_name: "King", value_symbol: "K", points: 10 },
  { value_name: "Ace", value_symbol: "A", points: 11 }
]

HIGHEST_SCORE = 21
DEALER_STICK_SCORE = 17
PLAYER_OPTIONS = { 'h' => 'Hit', 's' => 'Stick' }

def prompt(msg)
  puts "=> #{msg}"
end

def initialise_deck(deck)
  CARD_SUITS.each do |suit|
    CARD_VALUES.each do |value|
      deck << {
        suit_name: suit[:suit_name], suit_symbol: suit[:suit_symbol],
        value_name: value[:value_name], value_symbol: value[:value_symbol], points: value[:points]
      }
      deck.shuffle!
    end
  end
end

def deal_initial_cards(deck, hands)
  2.times do
    hands.each { |_, hand| deal_card(deck, hand, false) }
  end
end

def deal_card(deck, hand, announce_card=true)
  card = deck.shift
  hand << card
  announce_card(card) if announce_card
end

def show_cards(hand, hidden_card=false)
  cards = []
  hand.each { |card| cards << "#{card[:value_symbol]}#{card[:suit_symbol]}" }
  cards[0] = "??" if hidden_card
  cards.join("  ")
end

def show_score(hand, hidden_card=false)
  score = calculate_score(hand)
  score >= 10 ? score = "#{score}" : score = " #{score}"
  score = "??" if hidden_card
  score
end

def show_table(hands, dealer_hidden=true)
  system 'clear'
  puts "-----------------------------------------"
  puts " PLAYER | SCORE  | CARDS"
  puts "-----------------------------------------"
  puts " Player |   #{show_score(hands['Player'])}   | #{show_cards(hands['Player'])}"
  puts " Dealer |   #{show_score(hands['Dealer'], dealer_hidden)}   | #{show_cards(hands['Dealer'], dealer_hidden)}"
  puts "-----------------------------------------"
end

def busted?(hand)
  calculate_score(hand) > HIGHEST_SCORE ? true : false
end

def calculate_score(hand)
  score = 0
  hand.each { |card| score += card[:points] }
  score = reduce_aces(hand, score) if score > HIGHEST_SCORE && ace_count(hand) > 0
  score
end

def any_aces?(hand)
  value_symbols = []
  hand.each { |card| value_symbols << card[:value_symbol] }
  value_symbols.include?("A") ? true : false
end

def ace_count(hand)
  ace_count = 0
  hand.each { |card| ace_count += 1 if card[:value_symbol] == "A" }
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

def dealer_hit_or_stick(hand)
  calculate_score(hand) >= DEALER_STICK_SCORE ? "s" : "h"
end

def invalid_choice?(choice)
  PLAYER_OPTIONS.key?(choice)
end

def player_choice
  hit_or_stick = ""
  loop do
    prompt "Hit or Stick? (type H or S)"
    hit_or_stick = gets.chomp
    prompt "Sorry, that's not a valid choice" if !invalid_choice?(hit_or_stick.downcase)
    break if hit_or_stick.downcase == 'h' || hit_or_stick.downcase == 's'
  end
  hit_or_stick
end

def dealer_choice(hand)
  sleep(2)
  dealer_hit_or_stick(hand)
end

def announce_choice(player, choice)
  prompt "#{player} chose to #{PLAYER_OPTIONS[choice]}"
  sleep(1)
end

def announce_card(card)
  prompt "Card dealt was a #{card[:value_name]} of #{card[:suit_name]}"
  sleep(2)
end

def announce_bust(hands, current_player)
  show_table(hands, false)
  prompt "#{current_player} busted!" if busted?(hands[current_player])
end

def play_turn(deck, hands, current_player)
  loop do
    current_player == 'Dealer' ? show_table(hands, false) : show_table(hands)
    current_player == 'Player' ? hit_or_stick = player_choice : hit_or_stick = dealer_choice(hands[current_player])
    announce_choice(current_player, hit_or_stick)
    deal_card(deck, hands[current_player]) if hit_or_stick.downcase == "h"
    break if busted?(hands[current_player]) || hit_or_stick.downcase == "s"
  end
end

def declare_winner(hands)
  if busted?(hands['Player'])
    prompt 'Dealer wins'
  elsif busted?(hands['Dealer'])
    prompt 'Player wins'
  else
    prompt decide_winner(hands)
  end
end

def decide_winner(hands)
  if calculate_score(hands['Player']) == calculate_score(hands['Dealer'])
    "It's a tie"
  elsif calculate_score(hands['Player']) > calculate_score(hands['Dealer'])
    "Player wins!"
  else
    "Dealer wins!"
  end
end

def play_again?
  gets.chomp.downcase.start_with?('y') ? true : false
end

loop do
  deck = []
  initialise_deck(deck)
  hands = { 'Player' => [], 'Dealer' => [] }
  deal_initial_cards(deck, hands)

  play_turn(deck, hands, 'Player')

  if busted?(hands['Player'])
    announce_bust(hands, 'Player')
  else
    play_turn(deck, hands, 'Dealer')
    announce_bust(hands, 'Dealer') if busted?(hands['Dealer'])
  end
  declare_winner(hands)

  prompt "Play again?"
  break unless play_again?
end

prompt "Thanks for playing 21!"
