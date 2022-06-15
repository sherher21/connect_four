require './lib/connect_four_player.rb'

class Game
  attr_reader :board
  EMPTY_BOARD = [  1,  2,  3,  4,  5,  6,  7,
                   8,  9, 10, 11, 12, 13, 14,
                  15, 16, 17, 18, 19, 20, 21,
                  22, 23, 24, 25, 26, 27, 28,
                  29, 30, 31, 32, 33, 34, 35,
                  36, 37, 38, 39, 40, 41, 42]

  WINNING_COMBINATIONS = 
    [[0,  1,  2,  3 ], [1,  2,  3,  4 ], [2,  3,  4,  5 ], [3,  4,  5,  6 ],
     [7,  8,  9,  10], [8,  9,  10, 11], [9,  10, 11, 12], [10, 11, 12, 13],
     [14, 15, 16, 17], [15, 16, 17, 18], [16, 17, 18, 19], [17, 18, 19, 20],
     [21, 22, 23, 24], [22, 23, 24, 25], [23, 24, 25, 26], [24, 25, 26, 27],
     [28, 29, 30, 31], [29, 30, 31, 32], [30, 31, 32, 33], [31, 32, 33, 34],
     [35, 36, 37, 38], [36, 37, 38, 39], [37, 38, 39, 40], [38, 39, 40, 41],
     [0, 7,  14, 21 ], [7,  14, 21, 28], [14, 21, 28, 35], 
     [1, 8,  15, 22 ], [8,  15, 22, 29], [15, 22, 29, 36],
     [2, 9,  16, 23 ], [9,  16, 23, 30], [16, 23, 30, 37], 
     [3, 10, 17, 24 ], [10, 17, 24, 31], [17, 24, 31, 38],
     [4, 11, 18, 25 ], [11, 18, 25, 32], [18, 25, 32, 39],
     [5, 12, 19, 26 ], [12, 19, 26, 33], [19, 26, 33, 40],
     [6, 13, 20, 27 ], [13, 20, 27, 34], [20, 27, 34, 41],
     [0,  8,  16, 24], [1,  9,  17, 25], [2,  10, 18, 26], [3,  11, 19, 27],
     [7,  15, 23, 31], [8,  16, 24, 32], [9,  17, 25, 33], [10, 18, 26, 34],
     [14, 22, 30, 38], [15, 23, 31, 39], [16, 24, 32, 40], [17, 25, 33, 41],
     [6,  12, 18, 24], [5,  11, 17, 23], [4,  10, 16, 22], [ 3,  9, 15, 21],
     [13, 19, 25, 31], [12, 18, 24, 30], [11, 17, 23, 29], [10, 16, 22, 28],
     [20, 26, 32, 38], [19, 25, 31, 37], [18, 24, 30, 36], [17, 23, 29, 35]]

  COLUMNS = [[0, 7, 14, 21, 28, 35], [1, 8, 15, 22, 29, 36], [2, 9, 16, 23, 30, 37],
             [3, 10, 17, 24, 31, 38], [4, 11, 18, 25, 32, 39], [5, 12, 19, 26, 33, 40],
             [6, 13, 20, 27, 34, 41]]                
  
  def initialize
    @board = EMPTY_BOARD
    @player_one = nil
    @player_two = nil
    @game_count = 1
  end

  def play
    setup_game
    introduction
    continue_play
  end

  def continue_play
    play_game
    finish_game
    if play_again?
      @board = EMPTY_BOARD
      @current_player = @current_player == @player_one ? @player_two : @player_one
      continue_play
    end
  end

  def play_game
    @game_count % 2 == 1 ? @current_player = @player_one : @current_player = @player_two
    until board_full?
      display_board
      player_turn(@current_player)
      break if game_over?
      @current_player = @current_player == @player_one ? @player_two : @player_one
    end
    display_board
  end

  def finish_game
    puts "Game Over!"    
    if game_over?
      puts "#{@current_player.name} wins!"
    else
      puts "Tie game! Good luck next time."
    end
  end

  def board_full?
    @board.all? { |value| value.to_s.match(/[^\d]/) }
  end

  def player_turn(player)
    puts "#{player.name}'s turn. #{player.name}'s symbol is \"#{player.symbol}\"."
    puts "Enter the column you want to play:"
    play = gets.chomp.to_i
    until valid_play?(play)
      puts "Invalid play! Please enter a valid column you want to play:"
      play = gets.chomp.to_i
    end
    update_board(play, player.symbol)
  end

  def valid_play?(play)
    return false unless play.between?(1, 42)
    play = (play % 7) - 1
    COLUMNS[play].any? do |index|
      @board[index].to_s.match(/\d/)
    end
  end

  def update_board(play, symbol)
    play = (play % 7) - 1
    play_position = COLUMNS[play].select { |index|
      board[index].to_s.match(/\d/)}.max
    @board[play_position] = symbol
  end

  def play_again?
    puts "Would you like to play again? (Y/N)"
    play = gets.chomp
    while play.match(/^[^yn]$/i)
      puts "Invalid entry. Please enter a valid entry (Y/N):"
      play = gets.chomp
    end
    return play.downcase == "y"
  end

  def display_board
    puts <<-BOARD

    | #{board[0]}  | #{board[1]}  | #{board[2]}  | #{board[3]}  | #{board[4]}  | #{board[5]}  | #{board[6]}  |
    ------------------------------------
    | #{board[7]}  | #{board[8]}  | #{board[9]} | #{board[10]} | #{board[11]} | #{board[12]} | #{board[13]} |
    ------------------------------------
    | #{board[14]} | #{board[15]} | #{board[16]} | #{board[17]} | #{board[18]} | #{board[19]} | #{board[20]} |
    ------------------------------------
    | #{board[21]} | #{board[22]} | #{board[23]} | #{board[24]} | #{board[25]} | #{board[26]} | #{board[27]} |
    ------------------------------------
    | #{board[28]} | #{board[29]} | #{board[30]} | #{board[31]} | #{board[32]} | #{board[33]} | #{board[34]} |
    ------------------------------------
    | #{board[35]} | #{board[36]} | #{board[37]} | #{board[38]} | #{board[39]} | #{board[40]} | #{board[41]} |
    ------------------------------------
    
    BOARD
  end

  def create_player
    puts "Enter player name:"
    name = gets.chomp 
    until valid_name?(name)
      puts "Invalid name! Enter a new name:"
      name = gets.chomp
    end
    
    puts "Enter player symbol:"
    symbol = gets.chomp
    until valid_symbol?(symbol)
      puts "Invalid symbol! Enter a new symbol:"
      symbol = gets.chomp
    end
    Player.new(name, symbol)
  end

  def setup_game
    @player_one = create_player
    @player_two = create_player
  end

  def valid_name?(name)
    @player_one == nil || !@player_one.name.include?(name)
  end

  def valid_symbol?(symbol)
    return false if symbol.length > 1
    @player_one == nil || !@player_one.symbol.include?(symbol)
  end

  def game_over?(board = @board)
    WINNING_COMBINATIONS.any? do |row|
      [board[row[0]], board[row[1]], board[row[2]], board[row[3]]].uniq.length == 1  
    end
    
  end

  def introduction
    puts <<-INTRODUCTION

    Lets play Connect Four!

    First player to connect four horizontally, vertically, or diagonally wins.    
    Good luck!

    INTRODUCTION
  end
end
