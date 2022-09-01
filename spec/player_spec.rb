require 'player'

RSpec.describe Player do
  it "should initialize player" do
    player = Player.new("Tom")
  end
  it "should return name" do
    player = Player.new("Tom")
    expect(player.name).to eq "Tom"
  end
  it "should return boat_array" do
    player = Player.new("Tom")
    boat_array = Array.new(10) {Array.new(10, 0)}
    expect(player.boat_array).to eq boat_array
  end
  it "should return shots_array" do
    player = Player.new("Tom")
    shots_array = @shots_array = Array.new(10) {Array.new(10, ' ~ ')}
    expect(player.shots_array).to eq shots_array
  end
  it "should return boats left" do
    player = Player.new("Tom")
    boats_left = {carrier: [5,5], battleship: [4,4], cruiser: [3,3], submarine: [2,3], destroyer: [1,2]}
    expect(player.boats_left).to eq boats_left
  end
  it "should place a boat" do
    player = Player.new("Tom")
    player.place_boat(:carrier)
    expect(player.boats_left[:carrier][1]).to eq 0
  end
  it "should return a saved original boats array" do
    player = Player.new("Tom")
    boat_array = Array.new(10) {Array.new(10, 0)}
    expect(player.save_boat_array).to eq boat_array
  end

end