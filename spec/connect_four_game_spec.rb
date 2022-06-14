require './lib/connect_four_game.rb'

describe Game do
  subject(:game) {described_class.new}

  describe "#initialize" do
    it 'creates a blank board' do
      blank_board = [1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7]
      expect(game.board).to eql(blank_board)
    end

    it 'creates a board with no symbols on it' do
      not_blank_board = ["X", 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7,
        1, 2, 3, 4, 5, 6, 7]
      expect(game.board).not_to eql(not_blank_board)
    end
  end

  describe "#game_over?" do
    context "when the board has a row of 4" do
      it 'is game over' do
        board_row = ["X", "X", "X", "X", 5, 6, 7,
                     1, 2, 3, 4, 5, 6, 7,
                     1, 2, 3, 4, 5, 6, 7,
                     1, 2, 3, 4, 5, 6, 7,
                     1, 2, 3, 4, 5, 6, 7,
                     1, 2, 3, 4, 5, 6, 7]
        game.instance_variable_set(:@board, board_row)
        expect(game).to be_game_over
      end
    end

    context "when the board has a column of 4" do
      it "is game over" do
        board_col = ["X", 2, 3, 4, 5, 6, 7,
                     "X", 2, 3, 4, 5, 6, 7,
                     "X", 2, 3, 4, 5, 6, 7,
                     "X", 2, 3, 4, 5, 6, 7,
                     1, 2, 3, 4, 5, 6, 7,
                     1, 2, 3, 4, 5, 6, 7]
        game.instance_variable_set(:@board, board_col)
        expect(game).to be_game_over
      end
    end

    context "when the board has a diagonal of 4" do
      it "is game over" do
        board_dia = ["X", 2, 3, 4, 5, 6, 7,
                    1, "X", 3, 4, 5, 6, 7,
                    1, 2, "X", 4, 5, 6, 7,
                    1, 2, 3, "X", 5, 6, 7,
                    1, 2, 3, 4, 5, 6, 7,
                    1, 2, 3, 4, 5, 6, 7]
        game.instance_variable_set(:@board, board_dia)
        expect(game.game_over?).to be true
      end
    end

    context "when the board has a row of 3 or less" do
      it "is not game over" do
        board_row_incomplete = ["X", "X", "X", 4, 5, 6, 7,
                                1, 2, 3, 4, 5, 6, 7,
                                1, 2, 3, 4, 5, 6, 7,
                                1, 2, 3, 4, 5, 6, 7,
                                1, 2, 3, 4, 5, 6, 7,
                                1, 2, 3, 4, 5, 6, 7]
        expect(game.game_over?(board_row_incomplete)).to be false
      end
    end

    context "when the board has a column of 3 or less" do
      xit "is not game over" do
      end
    end

    context "when the board has a diagonal of 3 or less" do
      xit "is not game over" do
      end
    end


  end

  describe "#play_game" do
  end

  describe "#display_board" do
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

    it "store players into list" do
      player_count = game.instance_variable_get(:@player_list).length
      expect(player_count).to eq(2)
    end
  end


end
