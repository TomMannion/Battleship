require 'game'

RSpec.describe Game do
  it "should return current player" do
    player_1 = double :player
    player_2 = double :player
    game = Game.new([player_1, player_2])
    expect(game.current_player).to eq(player_1)
  end
  it "should return opposite player" do
    player_1 = double :player
    player_2 = double :player
    game = Game.new([player_1, player_2])
    expect(game.opposite_player).to eq(player_2)
  end
  it "should return true if opposite players boats are all sunk" do
    player_1 = double :player, boat_array: [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    player_2 = double :player, boat_array: [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    game = Game.new([player_1, player_2])
    expect(game.winner?).to eq(true)
  end
  it "should return false if opposite players boats are not all sunk" do
    player_1 = double :player, boat_array: [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    player_2 = double :player, boat_array: [[1,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    game = Game.new([player_1, player_2])
    expect(game.winner?).to eq(false)
  end
  it "should print You sunk my battleship!" do
    io = double :io
    player_1 = double :player, boat_array: [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    player_2 = double :player, boat_array: [[1,3,4,5,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    game = Game.new([player_1, player_2], io)
    expect(io).to receive(:puts).with("You sunk my battleship!")
    game.ship_sunk(2)
  end
  it "should switch players" do
    player_1 = double :player
    player_2 = double :player
    game = Game.new([player_1, player_2])
    game.switch_player
    expect(game.current_player).to eq(player_2)
  end
  it "should take a shot" do
    io = double :io
    player_1 = double :player, shots_array: [[0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    player_2 = double :player, boat_array: [[1,1,4,5,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0]]
    game = Game.new([player_1, player_2], io)
    expect(io).to receive(:puts).with(game.render_ascii_art("lib/hit.txt"))
    game.take_shot([0,0])
  end

end