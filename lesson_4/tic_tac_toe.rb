# tic_tac_toe.rb

require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(array, mainseparator=', ', finalseparator=' or ')
  final_item = array.pop
  if array.length > 1
    string = array.join(mainseparator) + ' ' + finalseparator + ' ' + final_item.to_s
  else
    string = final_item.to_s
  end
  string
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_scores
  scores = {'Player' => 0, 'Computer' => 0}
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def threat_squares(brd)
  threat_squares = []
  WINNING_LINES.each do |line|
    if brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 2 &&
       brd.values_at(line[0], line[1], line[2]).count(INITIAL_MARKER) == 1
      line.each { |square| threat_squares << square if brd[square] == INITIAL_MARKER }
    else
      nil
    end
  end
  threat_squares
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  if immediate_threat?(brd)
    square = threat_squares(brd).sample
  else
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def immediate_threat?(brd)
  !threat_squares(brd).empty?
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def overall_winner?(scores)
  !!detect_overall_winner(scores)
end

def increment_scores(scores, winner)
  scores[winner] += 1
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(line[0], line[1], line[2]).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_overall_winner(scores)
  if scores.values.include?(5)
    return scores.key(5)
  else
    nil
  end
end

loop do # overall game loop
  scores = initialize_scores
  prompt "Welcome to Tic Tac Toe!"

  loop do # individual game loop
    board = initialize_board
    display_board(board)

    loop do # game turn loop
      display_board(board)

      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      winner = detect_winner(board)
      prompt "#{winner} won!"
      increment_scores(scores, winner)
    else
      prompt "It's a tie!"
    end

    prompt "The scores are:"
    scores.each { |player, score| puts "#{player} has #{score}."}
    sleep(2)
    break if overall_winner?(scores)
  end

  prompt "#{detect_overall_winner(scores)} won the whole game!"
  prompt "Play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt "Thanks for playing Tic Tac Toe. Goodbye!"
