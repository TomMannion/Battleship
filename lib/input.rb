class Input
  def initialize(io = Kernel)
    @io = io
    @direction = ""
    @boat = ""
    @position = []
  end

  def get_coord
    @coord = @io.gets.chomp
  end

  def translate_coord(coord = self.get_coord)
    coord = coord.scan(/\d+|\D+/)
    coord[0] = coord[0].upcase.ord - 65
    coord[1] = coord[1].to_i
    coord[1] -= 1
    return coord
  end

  def get_name
    name = @io.gets.chomp
  end

  def get_direction
    @direction = @io.gets.chomp
  end

  def get_boat
    @boat = @io.gets.chomp
  end

  def boat_choice
    case @boat
    when "5"
      @boat = :carrier
    when "4"
      @boat = :battleship
    when "3"
      @boat = :cruiser
    when "2"
      @boat = :submarine
    when "1"
      @boat = :destroyer
    else
      @boat = :error
    end
  end

  def direction
    @direction
  end

end