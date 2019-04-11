require "./lib/board"

class Game
  def initialize
    @board = Board.new
    @width = 7
    @height = 6
    draw_board
    run
  end

  def run
    running = true
    until running == "q"
      print "Player? (1-2)"
      player = gets.chomp.to_i
      puts " "
      print "Column? (0-6)"
      column = gets.chomp.to_i
      puts " "
      @board.columns[column].place(player)
      draw_board
    end
  end



  #aesthetics
  def draw_board
    (0...@height).reverse_each do |row| draw_row(row) end
  end

  def draw_row(row)
    print "|"
    @board.columns.each_with_index do |col,i|
      column = @board.columns[i]
      slot = column.col_slots[row]
      char = char(slot.status)
      print "#{char}|"
    end
    print "\n"
    puts "-" + "--" * @width
  end

  def char(c)
    case c
    when 0
      val = " "
    when 1
      val = "\xE2\x97\x8B"
    when 2
      val = "\xE2\x97\x8F"
    end
    return val
  end

end

Game.new
