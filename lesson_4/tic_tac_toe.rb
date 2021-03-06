# tic_tac_toe.rb

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
BEST_SQUARE = 5
FIRST_GO = 'Choose'
PLAYERS = { 'P' => 'Player', 'C' => 'Computer' }

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(array, mainseparator=', ', finalseparator=' or ')
  final_item = array.pop
  if array.length > 0
    "#{array.join(mainseparator)} #{finalseparator} #{final_item}"
  else
    "#{final_item}"
  end
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
  { 'Player' => 0, 'Computer' => 0 }
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def select_player
  loop do
    prompt "Choose who goes first. P = Player, C = Computer"
    choice = gets.chomp.upcase
    break PLAYERS[choice] if PLAYERS.keys.include?(choice)
    prompt "Sorry, that's not a valid choice. Choose P or C"
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def threat_squares(brd, marker)
  threat_squares = []
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1
      line.each { |square| threat_squares << square if brd[square] == INITIAL_MARKER }
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
  if immediate_threat?(brd, COMPUTER_MARKER)
    brd[threat_squares(brd, COMPUTER_MARKER).sample] = COMPUTER_MARKER
  elsif immediate_threat?(brd, PLAYER_MARKER)
    brd[threat_squares(brd, PLAYER_MARKER).sample] = COMPUTER_MARKER
  elsif best_square_empty?(brd)
    brd[BEST_SQUARE] = COMPUTER_MARKER
  else
    brd[empty_squares(brd).sample] = COMPUTER_MARKER
  end
end

def place_piece!(brd, current_player)
  if current_player == 'Player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  current_player == 'Player' ? 'Computer' : 'Player'
end

def immediate_threat?(brd, marker)
  !threat_squares(brd, marker).empty?
end

def best_square_empty?(brd)
  brd[BEST_SQUARE] == INITIAL_MARKER
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
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_overall_winner(scores)
  scores.key(5) if scores.values.include?(5)
end

def play_again?
  gets.chomp.downcase.start_with?('y') ? true : false
end

loop do # overall game loop
  scores = initialize_scores
  prompt "Welcome to Tic Tac Toe!"
  current_player = ''
  FIRST_GO != 'Choose' ? current_player = FIRST_GO : current_player = select_player

  loop do # individual game loop
    board = initialize_board
    display_board(board)

    loop do # game turn loop
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
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
    scores.each { |player, score| puts "#{player} has #{score}." }
    sleep(2)
    break if overall_winner?(scores)
  end

  prompt "#{detect_overall_winner(scores)} won the whole game!"
  prompt "Play again?"
  break unless play_again?
end
prompt "Thanks for playing Tic Tac Toe. Goodbye!"
