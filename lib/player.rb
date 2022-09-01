class Player
  def initialize(name)
    @name = name
    @boat_array = Array.new(10) {Array.new(10, 0)}
    @saved_boat_array = []
    @shots_array = Array.new(10) {Array.new(10, ' ~ '.light_blue)}
    @boat_placed = {carrier: [5,5]} #, battleship: [4,4], cruiser: [3,3], submarine: [2,3], destroyer: [1,2]
  end

  def set_name_color(name)
    @name = name
  end

  def name
    @name
  end

  def boat_array
    @boat_array
  end

  def shots_array
    @shots_array
  end

  def boats_left
    @boat_placed
  end

  def save_boat_array
    @saved_boat_array =  @boat_array
  end

  def place_boat(boat)
    @boat_placed[boat][1] = 0
  end

end