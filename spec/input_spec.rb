require 'input'

RSpec.describe Input do
  it "should get the chosen coordinate" do
    io = double :io
    input = Input.new(io)
    expect(io).to receive(:gets).and_return("a1")
    input.get_coord
  end
  it "should translate the coordinate" do
    io = double :io
    input = Input.new(io)
    expect(io).to receive(:gets).and_return("a1")
    expect(input.translate_coord).to eq([0,0])
  end
  it "should get the chosen boat" do
    io = double :io
    input = Input.new(io)
    expect(io).to receive(:gets).and_return("1")
    input.get_boat
  end
  it "should get the chosen direction" do
    io = double :io
    input = Input.new(io)
    expect(io).to receive(:gets).and_return("h")
    input.get_direction
  end
  it "should get the chosen name" do
    io = double :io
    input = Input.new(io)
    expect(io).to receive(:gets).and_return("name")
    input.get_name
  end

end