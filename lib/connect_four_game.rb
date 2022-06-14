require './lib/connect_four_player.rb'

class Game
  attr_reader :board

  WINNING_ROWS = 
    [[0,  1,  2,  3 ], [1,  2,  3,  4 ], [2,  3,  4,  5 ], [3,  4,  5,  6 ],
     [7,  8,  9,  10], [8,  9,  10, 11], [9,  10, 11, 12], [10, 11, 12, 13],
     [14, 15, 16, 17], [15, 16, 17, 18], [16, 17, 18, 19], [17, 18, 19, 20],
     [21, 22, 23, 24], [22, 23, 24, 25], [23, 24, 25, 26], [24, 25, 26, 27],
     [28, 29, 30, 31], [29, 30, 31, 32], [30, 31, 32, 33], [31, 32, 33, 34],
     [35, 36, 37, 38], [36, 37, 38, 39], [37, 38, 39, 40], [38, 39, 40, 41]]
  WINNING_COLUMNS = 
    [[0, 7,  14, 21 ], [7,  14, 21, 28], [14, 21, 28, 35], 
     [1, 8,  14, 22 ], [8,  15, 22, 29], [15, 22, 29, 36],
     [2, 9,  16, 23 ], [9,  16, 23, 30], [16, 23, 30, 37], 
     [3, 10, 17, 24 ], [10, 17, 24, 31], [17, 24, 31, 38],
     [4, 11, 18, 25 ], [11, 18, 25, 32], [18, 25, 32, 39],
     [5, 12, 19, 26 ], [12, 19, 26, 33], [19, 26, 33, 40],
     [6, 13, 20, 27 ], [13, 20, 27, 34], [20, 27, 34, 41]]
  WINNING_DIAGONALS = 
    [[0,  8,  16, 24], [1,  9,  17, 25], [2,  10, 18, 26], [3,  11, 19, 27],
     [7,  15, 23, 31], [8,  16, 24, 32], [9,  17, 25, 33], [10, 18, 26, 34],
     [14, 22, 30, 38], [15, 23, 31, 39], [16, 24, 32, 40], [17, 25, 33, 41],
     [6,  12, 18, 24], [5,  11, 17, 23], [4,  10, 16, 22],
     [13, 19, 25, 31], [12, 18, 24, 30], [11, 17, 23, 29],
     [20, 26, 32, 38], [19, 25, 31, 37], [18, 24, 30, 36]]

                  
  
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7,
              1, 2, 3, 4, 5, 6, 7,
              1, 2, 3, 4, 5, 6, 7,
              1, 2, 3, 4, 5, 6, 7,
              1, 2, 3, 4, 5, 6, 7,
              1, 2, 3, 4, 5, 6, 7]
  end

  def play
    setup_game
    puts introduction
    while play_again? do
      play_game      
    end
    finish_game
  end

  def play_game
    @current_player = @player_one
    until board_full?

    end
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
    @player_list = [@player_one, @player_two]
  end

  def valid_name?(name)
    @player_one[:name].include?(name) || @player_two[:name].include?(name)
  end

  def valid_symbol?(symbol)
    @player_one[:symbol].include?(symbol) || @player_two[:symbol].include?(symbol)
  end

  def game_over?(board = @board)
    result = WINNING_COMBINATIONS.any? do |combo|
      [board[combo[0]], board[combo[1]], board[combo[2]], board[combo[3]]].uniq.length == 1
    end
    return result
  end
end
