# 21_game.rb

require 'pry'

CARD_SUITS = [
  {suit_name: "Spades", suit_symbol: "\u2660"},
  {suit_name: "Hearts", suit_symbol: "\u2665"},
  {suit_name: "Clubs", suit_symbol: "\u2663"},
  {suit_name: "Diamonds", suit_symbol: "\u2666"}
   ]

CARD_VALUES = [
  {value_name: "One", value_symbol: "1", points: 1},
  {value_name: "Two", value_symbol: "2", points: 2},
  {value_name: "Three", value_symbol: "3", points: 3},
  {value_name: "Four", value_symbol: "4", points: 4},
  {value_name: "Five", value_symbol: "5", points: 5},
  {value_name: "Six", value_symbol: "6", points: 6},
  {value_name: "Seven", value_symbol: "7", points: 7},
  {value_name: "Eight", value_symbol: "8", points: 8},
  {value_name: "Nine", value_symbol: "9", points: 9},
  {value_name: "Ten", value_symbol: "10", points: 10},
  {value_name: "Jack", value_symbol: "J", points: 10},
  {value_name: "Queen", value_symbol: "Q", points: 10},
  {value_name: "King", value_symbol: "K", points: 10},
  {value_name: "Ace", value_symbol: "A", points: 11},
  ]

HIGHEST_SCORE = 21
DEALER_STICK_SCORE = 17

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

def deal_initial_cards(deck, player_hand, dealer_hand)
  2.times do
    deal_card(deck, player_hand)
    deal_card(deck, dealer_hand)
  end
end

def deal_card(deck, hand)
  hand << deck.shift
end

def show_table(player_hand, dealer_hand, hidden=true)
  system 'clear'
  player_cards = []
  dealer_cards = []
  player_hand.each { |card| player_cards << "#{card[:value_symbol]}#{card[:suit_symbol]}"}
  dealer_hand.each { |card| dealer_cards << "#{card[:value_symbol]}#{card[:suit_symbol]}"}
  dealer_cards[0] = "??" if hidden
  puts "-----------------------------------------"
  puts "Player: #{player_cards.join(" ")}"
  puts "Dealer: #{dealer_cards.join(" ")}"
  puts "-----------------------------------------"
end

def busted?(hand)
  calculate_score(hand) > HIGHEST_SCORE ? true : false
end

def calculate_score(hand)
  score = 0
  hand.each { |card| score += card[:points]}
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

def declare_winner(player_hand, dealer_hand)
  calculate_score(player_hand) == calculate_score(dealer_hand) ? "It's a tie" : calculate_score(player_hand) > calculate_score(dealer_hand) ? "Player wins!" : "Dealer wins!"
end

def play_again?
  gets.chomp.downcase.start_with?('y') ? true : false
end



loop do
  deck = []
  initialise_deck(deck)
  player_hand = []
  dealer_hand = []
  deal_initial_cards(deck, player_hand, dealer_hand)

  loop do # player loop
    show_table(player_hand, dealer_hand)
    puts "Hit or Stick? (type H or S)"
    hit_or_stick = gets.chomp
    deal_card(deck, player_hand) if hit_or_stick.downcase == "h"
    break if busted?(player_hand) || hit_or_stick.downcase == "s"
  end
  show_table(player_hand, dealer_hand)
  puts "You busted! Dealer wins!" if busted?(player_hand)

  if !busted?(player_hand)
    loop do # player loop
      show_table(player_hand, dealer_hand, false)
      puts "Hit or Stick? (type H or S)"
      hit_or_stick = dealer_hit_or_stick(dealer_hand)
      deal_card(deck, dealer_hand) if hit_or_stick.downcase == "h"
      sleep(2)
      break if busted?(dealer_hand) || hit_or_stick.downcase == "s"
    end
    show_table(player_hand, dealer_hand, false)
    puts "Dealer busted! You win!" if busted?(dealer_hand)
  end

  if !busted?(player_hand) && !busted?(dealer_hand)
    puts declare_winner(player_hand, dealer_hand)
  end

  puts "Play again?"
  break unless play_again?
end

puts "Thanks for playing 21!"





