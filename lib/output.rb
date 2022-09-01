require 'colorize'

class Output
  def initialize(io = Kernel)
    @io = io
  end

  def clear
    @io.print "\033[2J\033[H"
  end

  
  def flash(msg)
    10.times do
      @io.print "\r#{ msg }"
      sleep 0.5
      @io.print "\r#{ ' ' * (msg.size-1) }" # Send return and however many spaces are needed.
      sleep 0.5
    end
  end

  def dialogue(text)
    text.each_char {|c| putc c ; sleep 0.01; $stdout.flush }
  end

  def enter_name(player)
    @io.print "#{player} Please enter your name: ".colorize(:red)
  end
  def ask_for_ship(player)
    if player.boats_left[:carrier][1] > 0 then @io.puts "5. Carrier - Length: 5" else @io.puts "Carrier has been placed.".red end
    #if player.boats_left[:battleship][1] > 0 then @io.puts "4. Battleship - Length: 4" else @io.puts "Battleship has been placed.".red end
    #if player.boats_left[:cruiser][1] > 0 then @io.puts "3. Cruiser - Length: 3" else @io.puts "Cruiser has been placed.".red end 
    #if player.boats_left[:submarine][1] > 0 then @io.puts "2. Submarine - Length: 3" else @io.puts "Submarine has been placed.".red end 
    #if player.boats_left[:destroyer][1] > 0 then @io.puts "1. Destroyer - Length: 2" else @io.puts "Destroyer has been placed.".red end
    self.dialogue("#{player.name}"+" - Please enter a choice between 1-5 to choose a ship to place: ".red)
  end
  def get_coord(player)
    self.dialogue("#{player}" + " - Please enter a coordinate from the board above: ".green)
  end
  def get_direction(player)
    self.dialogue("#{player}" + " - Please enter\n-"+"H".green+" for the boat to be placed Horizontally\n-"+"V".green+" for Vertically: ")
  end
  def ask_for_shot(player)
    self.dialogue("#{player}" + " - Take your best shot! Please enter a coordinate from the board above: ".green)
  end

  def print_board(board)
    letters = ("A".."J").to_a
    numbers = (1..10).to_a

    return_board = board.map{|row| row.map{ |num| num == 0 ? num = " ~ ".light_blue : num = " #{num} "}}
    header = "   " + numbers.join("  ") + "\n"

    @io.print header.green
    return_board.each_with_index do |element, index|
      @io.print letters[index].green + " " + element.join("")+ "\n"
    end
  end

  def print_shots_board(board)
    letters = ("A".."J").to_a
    numbers = (1..10).to_a

    header = "   " + numbers.join("  ").green + "\n"

    @io.print header
    board.each_with_index do |element, index|
      @io.print letters[index].green + " " + element.join("") + "\n"
    end
  end

  def print_winner
    @io.print "#{player} you have WON!"
  end
end