class Setup
  def initialize(players)
    @players = players
    @current_player = @players[0]
    @time_to_start = false
  end

  def set_player_color
    @players[0].set_name_color(@players[0].name.light_yellow)
    @players[1].set_name_color(@players[1].name.light_magenta)
  end

  def translate_coordinate(position)
    position_array = position.scan(/\d+|\D+/)
    position_array[0] = position_array[0].upcase.ord - 65
    position_array[1] = position_array[1].to_i
    position_array[1] -= 1
    return position_array
  end

  def in_bounds?(direction, boat, position)
    letter_coord = position[0]
    number_coord = position[1]
    boat_length = @current_player.boats_left[boat][1]
    if "H" == direction && (number_coord >= 0 && letter_coord >= 0) && ((number_coord+boat_length) <= 9 && letter_coord <= 9)
      return true
    elsif "V" == direction && (number_coord >= 0 && letter_coord >= 0) && ((letter_coord+boat_length) <= 9 && number_coord <= 9)
      return true
    else
      puts "This choice is out of bounds."
      return false
    end
  end

  def overlapping?(direction, position, boat)
    letter_coord = position[0]
    number_coord = position[1]
    boat_length = @current_player.boats_left[boat][1]
    current_board = @current_player.boat_array
    boat_position = []
    if direction == "H"
      boat_length.times { |i| boat_position << current_board[letter_coord][number_coord + i].to_i }
    else
      boat_length.times { |i| boat_position << current_board[letter_coord + i][number_coord].to_i }
    end
    if boat_position.sum == 0
      return true
    else
      puts "Your boats are overlapping, please choose again."
      return false
    end
  end

  def place_boat(direction, boat, position)
    letter_coord = position[0]
    number_coord = position[1]
    current_board = @current_player.boat_array
    boat_choice = @current_player.boats_left[boat][0]
    boat_length = @current_player.boats_left[boat][1]
    if self.in_bounds?(direction, boat, position) && self.overlapping?(direction, position, boat) && boat_choice > 0
      if direction == "H"
        boat_length.times { |i| current_board[letter_coord][number_coord + i] = boat_choice }
      else
        boat_length.times { |i| current_board[letter_coord + i][number_coord] = boat_choice }
      end
      @current_player.place_boat(boat)
    end
    self.switch_player
  end

  def current_player
    @current_player
  end

  def switch_player
    if self.all_boats_placed?
      puts "Player 2 Time to prepare for battle!"
    end
  end

  def all_boats_placed?(player = @current_player)
    if player.boats_left.values.all? { |value| value[1] == 0 }
      @current_player = @players[1]
      return true
    end
  end

  def time_to_start?
    if self.all_boats_placed?(@players[0]) && self.all_boats_placed?(@players[1])
      @players[0].save_boat_array
      @players[1].save_boat_array
      @time_to_start = true
    end
  end

end

