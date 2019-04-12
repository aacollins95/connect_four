require "./lib/board"

class Game
  def initialize
    @board = Board.new
    @width = 7
    @height = 6
    @player = 1
    draw_board
    run
  end

  def run
    #runs the game with a display
    win = false
    until win
      puts "Player #{@player}'s Turn!"
      puts "Choose a column"
      col = get_col
      @board.columns[col].place(@player)
      draw_board
      win = @board.check_win(col)
      win_player = @player if win
      change_player
    end
    draw_ending(win_player)
  end

  def change_player
    #switches player
    if @player == 1
      @player = 2
    else
      @player = 1
    end
  end

  def get_col
    #makes sure user inputs a valid column
    valid = false
    until valid
      col = gets.chomp.to_i
      in_range = 0 < col && col <= @width
      col_empty =
      if in_range && !@board.columns[col-1].col_slots.all? do |s| s.status>0 end
        valid = true
      else
        puts "Please choose an empty column between 1 and 7"
      end
    end
    return col-1
  end

  #aesthetics
  def draw_board
    print "\n"*16
    (0...@height).reverse_each do |row| draw_row(row) end
    print " "
    (1..@width).each do |i| print "#{i}  " end
    puts " "
  end

  def draw_row(row)
    @board.columns.each_with_index do |col,i|
      column = @board.columns[i]
      slot = column.col_slots[row]
      char = char(slot.status)
      print " #{char} "
    end
    print "\n"*2
  end

  def draw_ending(player)
    puts "Player #{player} wins the game!"
  end

  def char(c)
    case c
    when 0
      val = "\xE2\x97\x8B" #empty
    when 1
      val = "\xE2\x97\x89" #bull
    when 2
      val = "\xE2\x97\x8e" #fish
    end
    return val
  end

end

Game.new
