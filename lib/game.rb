class Game

  def initialize(players, io = Kernel)
    @io = io
    @players = players
    #@players_turn = "player_1"
    @opposite_player = players[1]
    @current_player = players[0]
  end

  def current_player
    @current_player
  end

  def opposite_player
    @opposite_player
  end

  def get_coord
    @coord = gets.chomp
    # until @coord[0] =~ (/[a-jA-J]/) && (@coord[1,2].to_i <= 10 && @coord[1,2].to_i > 0)
    #   @coord = gets.chomp
    # end
    position_array = @coord.scan(/\d+|\D+/)
    position_array[0] = position_array[0].upcase.ord - 65
    position_array[1] = position_array[1].to_i
    position_array[1] -= 1
    return position_array
  end

  def render_ascii_art(file)
    File.read(file)
  end

  def take_shot(target)
    coords = target
    boat_number = @opposite_player.boat_array[coords[0]][coords[1]]
    if boat_number > 0
      @io.puts self.render_ascii_art("lib/hit.txt").red
      @opposite_player.boat_array[coords[0]][coords[1]] = 0
      @current_player.shots_array[coords[0]][coords[1]] = " x ".red
      self.ship_sunk(boat_number)
    else
      @current_player.shots_array[coords[0]][coords[1]] = " o ".white
      @io.puts "You made a splash!".light_blue
    end
  end

  def switch_player
    sleep(2)
    @current_player, @opposite_player = @opposite_player, @current_player
  end

  def ship_sunk(boat_number)
    if @opposite_player.boat_array.flatten.include?(boat_number) == false
      @io.puts "You sunk my battleship!".red
    end
  end

  def winner?
    @current_player.boat_array.flatten.sum == 0
  end

end