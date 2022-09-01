##### Things to do ########
# create class variables for refactoring methods such as @boat @direction etc...
# Might need getters and setters
# Need to think about class structure
# Need to verify hits and misses
# Need a way to monitor which boats have been placed
# thinking number system for boats
# when no numbers left for a boat say "You sunk my battleship"
# win when all ships are gone
# Show winners placement
# Classes maybe - Player(holds array for their choices and hit/miss array)
# Print class
# game_play class (check whos turn it is, check if anyone has won)
## maybe add computer with basic logic


t = Array.new(10) {Array.new(10, " . ")}

def translate_coordinate(position)
  position_array = position.scan(/\d+|\D+/)
  position_array[0] = position_array[0].upcase.ord - 65
  position_array[1] = position_array[1].to_i
  position_array[1] -= 1
  return position_array
end

def in_bounds

  "H" == direction ? 
    (number_coord >= 0 && letter_coord >= 0) && ((number_coord+boat) <= 9 && letter_coord <= 9) 
    : (number_coord >= 0 && letter_coord >= 0) && ((letter_coord+boat) <= 9 && number_coord <= 9)
end

def set_boats(boat, start_position, direction, array)
  start_position = translate_coordinate(start_position)
  letter_coord = start_position[0]
  number_coord = start_position[1]

  # return true 
  in_bounds = "H" == direction ? 
    (number_coord >= 0 && letter_coord >= 0) && ((number_coord+boat) <= 9 && letter_coord <= 9) 
    : (number_coord >= 0 && letter_coord >= 0) && ((letter_coord+boat) <= 9 && number_coord <= 9)

  if in_bounds
    if direction == "H"
      boat.times { |i| array[letter_coord][number_coord + i] = " x " }
    else
      boat.times { |i| array[letter_coord + i][number_coord] = " x " }
    end
    boat_placed(boat)
    return array
  end
end


def print_board(array)

  letters = ("A".."J").to_a
  numbers = (1..10).to_a

  header = "   " + numbers.join("  ") + "\n"

  print header
  array.each_with_index do |element, index|
    print letters[index] + " " + element.join("") + "\n"
  end

end

#translate_coordinate("B10")
print_board(set_boats(5, "C7", "H", t))