require_relative 'setup'
require_relative 'battleships'
require_relative 'game'
require_relative 'input'
require_relative 'output'
require_relative 'player'
require 'colorize'

output = Output.new
input = Input.new

# play against computer or player
# player 1 enter your name

output.enter_name("Player one")
player_1 = Player.new(input.get_name)
output.enter_name("Player two")
player_2 = Player.new(input.get_name)
setup = Setup.new([player_1, player_2])
game = Game.new([player_1, player_2])
setup.set_player_color

# please place your ships ready for battle
while !setup.time_to_start?

  output.clear
  #puts output.print_title
  output.print_board(setup.current_player.boat_array)
  output.ask_for_ship(setup.current_player)
  boat = ""
  while boat = input.get_boat
    case boat
    when "1", "2", "3", "4", "5"
      boat = input.boat_choice
      break
    else
      print "Please try again: "
    end
  end
  
  position = ""
  output.get_coord(setup.current_player.name)
  while position = input.get_coord
    case position
    when /^[a-jA-J]+[0-9]+$/
      position = input.translate_coord(position)
      break
    else
      print "Please try again: "
    end
  end

  direction = ""
  output.get_direction(setup.current_player.name)
  while direction = input.get_direction.upcase
    case direction
    when "H", "V"
      setup.place_boat(direction, boat, position)
      break
    else
      print "Please try again: "
    end
  end

  output.print_board(setup.current_player.boat_array)

  setup.all_boats_placed?
end


while !game.winner?

  output.clear

  output.print_shots_board(game.current_player.shots_array)
  output.ask_for_shot(game.current_player.name)

  shot = ""
  while shot = input.get_coord
    coord = input.translate_coord(shot)
    case shot
    when /^[a-jA-J]+[0-9]+$/
      shot = input.translate_coord(shot)
      if game.current_player.shots_array[shot[0]][shot[1]] != (" x ".red || " o ".white)
        break
      else
        print "Please try again: "
      end
    else
      print "Please try again: "
    end
  end

  game.take_shot(shot)

  game.switch_player

end
puts "Congratulations #{game.opposite_player.name}! You win!"
puts game.render_ascii_art("lib/winner.txt").light_yellow
sleep (10)

# place ship until no more left
# switch
# player 2 enter your name
# place ships until no more left
# prepare for battle
# until either player has no ships left
  # player 1 take your shot - if ship fully sunk say "you sunk my battleship!"
  # switch
  # player 2 take shot
# player x has won the battle
# show players layout