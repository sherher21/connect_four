require './lib/connect_four_game.rb'

describe Game do
  subject(:game) {described_class.new}

  describe "#initialize" do
    it 'creates a blank board' do
      blank_board = [ 1,  2,  3,  4,  5,  6,  7,
                      8,  9, 10, 11, 12, 13, 14,
                     15, 16, 17, 18, 19, 20, 21,
                     22, 23, 24, 25, 26, 27, 28,
                     29, 30, 31, 32, 33, 34, 35,
                     36, 37, 38, 39, 40, 41, 42]
      expect(game.board).to eql(blank_board)
    end

    it 'creates a board with no symbols on it' do
      not_blank_board = ["X",  2,  3,  4,  5,  6,  7,
                          8,  9, 10, 11, 12, 13, 14,
                         15, 16, 17, 18, 19, 20, 21,
                         22, 23, 24, 25, 26, 27, 28,
                         29, 30, 31, 32, 33, 34, 35,
                         36, 37, 38, 39, 40, 41, 42]
      expect(game.board).not_to eql(not_blank_board)
    end
  end

  describe "#game_over?" do
    context "when the board has a row of 4" do
      it 'is game over' do
        board_row = [ "X","X","X","X",  5,  6,  7,
                        8,  9, 10, 11, 12, 13, 14,
                       15, 16, 17, 18, 19, 20, 21,
                       22, 23, 24, 25, 26, 27, 28,
                       29, 30, 31, 32, 33, 34, 35,
                       36, 37, 38, 39, 40, 41, 42]
        result = game.game_over?(board_row)
        expect(result).to be true
      end
    end

    context "when the board has a column of 4" do
      it "is game over" do
        board_col = ["X",  2,  3,  4,  5,  6,  7,
                     "X",  9, 10, 11, 12, 13, 14,
                     "X", 16, 17, 18, 19, 20, 21,
                     "X", 23, 24, 25, 26, 27, 28,
                      29, 30, 31, 32, 33, 34, 35,
                      36, 37, 38, 39, 40, 41, 42]
        result = game.game_over?(board_col)
        expect(result).to be true
      end
    end

    context "when the board has a diagonal of 4" do
      it "is game over" do
        board_dia = ["X",  2,  3,  4,  5,  6,  7,
                       8,"X", 10, 11, 12, 13, 14,
                      15, 16,"X", 18, 19, 20, 21,
                      22, 23, 24,"X", 26, 27, 28,
                      29, 30, 31, 32, 33, 34, 35,
                      36, 37, 38, 39, 40, 41, 42]
        result = game.game_over?(board_dia)
        expect(result).to be true
      end
    end

    context "when the board has a row of 3 or less" do
      it "is not game over" do
        board_row_incomplete =  ["X","X","X",  4,  5,  6,  7,
                                   8,  9, 10, 11, 12, 13, 14,
                                  15, 16, 17, 18, 19, 20, 21,
                                  22, 23, 24, 25, 26, 27, 28,
                                  29, 30, 31, 32, 33, 34, 35,
                                  36, 37, 38, 39, 40, 41, 42]
        result = game.game_over?(board_row_incomplete)           
        expect(result).to be false
      end
    end

    context "when the board has a diagonal of 3 or less" do
      it "is not game over" do
        board_dia_incomplete = ["X",  2,  3,  4,  5,  6,  7,
                                  8,"X", 10, 11, 12, 13, 14,
                                 15, 16,"X", 18, 19, 20, 21,
                                 22, 23, 24, 25, 26, 27, 28,
                                 29, 30, 31, 32, 33, 34, 35,
                                 36, 37, 38, 39, 40, 41, 42] 
        result = game.game_over?(board_dia_incomplete)
        expect(result).to be false
      end
    end

    context "when the board has a column of 3 or less" do
      it "is not game over" do
        board_col_incomplete = ["X",  2,  3,  4,  5,  6,  7,
                                "X",  9, 10, 11, 12, 13, 14,
                                "X", 16, 17, 18, 19, 20, 21,
                                 22, 23, 24, 25, 26, 27, 28,
                                 29, 30, 31, 32, 33, 34, 35,
                                 36, 37, 38, 39, 40, 41, 42]
        result = game.game_over?(board_col_incomplete)
        expect(result).to be false
      end
    end
  end

  describe "#play" do
  end

  describe "#play_game" do
  end

  describe "#display_board" do
    before do
      allow(game).to receive(:puts)
    end
    it 'calls puts to display board' do
      expect(game).to receive(:puts).exactly(1).time
      game.display_board
    end
  end

  describe "#create_player" do
    let(:player) { double('player')}
    context 'when creating a new player' do  
      before do
        name = "john"
        symbol = "Y"
        symbol_prompt = "Enter player symbol:"
        name_prompt = "Enter player name:"
        allow(game).to receive(:puts).and_return(name_prompt)
        allow(game).to receive(:puts).and_return(symbol_prompt)
        allow(game).to receive(:gets).and_return(name)
        allow(player).to receive(:new)
        allow(game).to receive(:valid_name?).and_return(true)
        allow(game).to receive(:valid_symbol?).and_return(true)
      end

      it 'prompts for player symbol' do        
        expect(game).to receive(:puts).with("Enter player symbol:")
        game.create_player
      end

      it 'prompts for player name' do        
        expect(game).to receive(:puts).with("Enter player name:")
        game.create_player
      end     

      it 'reads input for player name and symbol' do
        expect(game).to receive(:gets).twice
        game.create_player
      end
    end

    context "when player name invalid once" do
      before do
        invalid_name = "jane"
        valid_name = "janice"
        name_error = "Invalid name! Enter a new name:"
        symbol_error = "Invalid symbol! Enter a new name:"
        allow(game).to receive(:puts).and_return(name_error)
        allow(game).to receive(:puts).and_return(name_error)
        allow(game).to receive(:valid_name?).and_return(false, true)
        allow(game).to receive(:valid_symbol?).and_return(false, true)
      end

      it 'completes loop and display name error message once' do
        expect(game).to receive(:puts).with("Invalid name! Enter a new name:").exactly(1).time
        game.create_player
      end

      it 'completes loop and display symbol error message once' do
        expect(game).to receive(:puts).with("Invalid symbol! Enter a new symbol:").exactly(1).time
        game.create_player
      end
    end
  end

  describe "#setup_game" do
    before do
      allow(game).to receive(:create_player)
      game.instance_variable_set(:@player_list, [{name: "john", symbol: "Y"}, {name: "jane", symbol: "X"}])
    end

    it "creates 2 players" do
      expect(game).to receive(:create_player).twice
      game.setup_game
    end
  end

  describe "#valid_name?" do
    context "when creating player one" do
      it "returns true" do
        name = "john"
        expect(game.valid_name?(name)).to be true
      end
    end
    
    context "when name is not equal to player one name" do
      let(:player) { double('player', name:"john")}
      before do  
        game.instance_variable_set(:@player_one, player)
      end
      it "returns true" do
        result = game.valid_name?("jane")
        expect(result).to be true
      end
    end

    context "when name is equal to player one name" do
      let(:player) { double('player', name:"john")}
      before do
        game.instance_variable_set(:@player_one, player)
      end
      it "returns false" do
        result = game.valid_name?("john")
        expect(result).to be false
      end
    end
  end

  describe "#valid_symbol?" do
    context "when creating player one" do
      it "returns true" do
        symbol = "X"
        expect(game.valid_symbol?(symbol)).to be true
      end
    end

    context "when symbol is not equal to player one symbol" do
      let(:player) { double('player', symbol: "Y")}
      before do
        game.instance_variable_set(:@player_one, player)
      end
      it "returns true" do
        symbol = "X"
        expect(game.valid_symbol?(symbol)).to be true
      end
    end

    context "when symbol is more than 1 character" do
      it "returns false" do
        symbol = "hello"
        expect(game.valid_symbol?(symbol)).to be false
      end
    
    end
  end

  describe "#finish_game" do
    context "when game is over" do
      let(:current_player) {double('player', name: "john")}
      before do
        allow(game).to receive(:game_over?).and_return(true)
        game.instance_variable_set(:@current_player, current_player)
      end
      it "display winner" do
        win_message = "john win!"
        expect(game).to receive(:puts).with(win_message)
        game.finish_game
      end
    end

    context "when game is tie" do
      before do
        allow(game).to receive(:game_over?).and_return(false)
      end
      it "display tie message" do
        tie_message = "Tie game! Good luck next time."
        expect(game).to receive(:puts).with(tie_message)
        game.finish_game        
      end
    end
  end

  describe "#board_full?" do
    context "when there are no more digits on the board" do
      before do
        full_board = ["X", 'A',  'B',  "C",  "D",  "E",  "F",
                 "X",  "G", "H", "I", "J", "K", "L",
                 "X", "M", "N", "O", "P", "Q", "R",
                 "X", "S", "T", "U", "V", "W", "X",
                 "Y", "Z", "A", "B", "C", "D", "E",
                 "F", "G", "H", "I", "j", "k", "l"] 
        game.instance_variable_set(:@board, full_board)
      end
      it "returns true" do
        expect(game.board_full?).to be true
      end
    end

    context "when there are still digits on the board" do
      before do
        unfull_board = ["X",  2,  3,  4,  5,  6,  7,
          8,"X", 10, 11, 12, 13, 14,
         15, 16,"X", 18, 19, 20, 21,
         22, 23, 24,"X", 26, 27, 28,
         29, 30, 31, 32, 33, 34, 35,
         36, 37, 38, 39, 40, 41, 42]
        game.instance_variable_set(:@board, unfull_board)
      end
      it "returns false" do
        expect(game.board_full?).to be false
      end
    end
  end

  describe "#player_turn" do
    context "when player inputs two invalid plays and then a valid play" do
      let(:player) { double('player', name: "john", symbol: "X")}
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:valid_play?).and_return(false, false, true)
        allow(game).to receive(:gets).and_return("5")
        allow(game).to receive(:update_board)
      end      
      it "puts error message twice" do
        error_message = "Invalid play! Please enter a valid column you want to play:"
        expect(game).to receive(:puts).with(error_message).twice
        game.player_turn(player)
      end

      it "updates the board" do
        expect(game).to receive(:update_board)
        game.player_turn(player)
      end
    end
  end

  describe "#valid_play?" do
    context "when play is not between 1 and 42" do
      it "returns false" do
        play = 0
        expect(game.valid_play?(play)).to be false
      end
    end

    context "when column is not full" do
      before do
        not_full_col_board = ["X",  2,  3,  4,  5,  6,  7,
          "X",  9, 10, 11, 12, 13, 14,
          "X", 16, 17, 18, 19, 20, 21,
          "X", 23, 24, 25, 26, 27, 28,
           29, 30, 31, 32, 33, 34, 35,
           36, 37, 38, 39, 40, 41, 42]
        game.instance_variable_set(:@board, not_full_col_board)
      end
      it "returns true" do
        play = 1
        expect(game.valid_play?(play)).to be true
      end
    end

    context "when column is full" do
      before do
        full_col_board = ["X",  2,  3,  4,  5,  6,  7,
          "X",  9, 10, 11, 12, 13, 14,
          "X", 16, 17, 18, 19, 20, 21,
          "X", 23, 24, 25, 26, 27, 28,
           "I", 30, 31, 32, 33, 34, 35,
           "A", 37, 38, 39, 40, 41, 42] 
        game.instance_variable_set(:@board, full_col_board)
      end
      it "returns false" do
        play = 1
        expect(game.valid_play?(1)).to be false
      end
    end
  end

  describe "#update_board" do
    it "updates the board" do
      play = 1
      symbol = "X"
      updated_board = [ 1,  2,  3,  4,  5,  6,  7,
        8,  9, 10, 11, 12, 13, 14,
       15, 16, 17, 18, 19, 20, 21,
       22, 23, 24, 25, 26, 27, 28,
       29, 30, 31, 32, 33, 34, 35,
       "X", 37, 38, 39, 40, 41, 42]
      game.update_board(play, symbol)
      expect(game.board).to eq(updated_board)
    end
  end

  describe "#play_again?" do
    context "when input is 'Y/y'" do
      before do
        allow(game).to receive(:gets).and_return("y")
        allow(game).to receive(:puts)
      end
      it "returns true" do
        expect(game.play_again?).to be true
      end
    end

    context "when input is 'N/n'" do
      before do
        allow(game).to receive(:gets).and_return("n")
        allow(game).to receive(:puts)
      end
      it "returns false" do
        expect(game.play_again?).to be false
      end
    end

    context "when invalid input is entered two times" do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return("a", 'B', "y")
      end
      it "prints error message two times" do
        error_message = "Invalid entry. Please enter a valid entry (Y/N):"
        expect(game).to receive(:puts).with(error_message).twice
        game.play_again?
      end
    end
  end
end
