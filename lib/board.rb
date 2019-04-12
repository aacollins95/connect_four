class Board
  attr_reader :columns
  def initialize
    @width = 7
    @height = 6
    @columns = Array.new
    (0...@width).each do |i| @columns.push(Column.new(i)) end
  end

  def check_win(col)
    root = last_placed(col)
    pointers = root.match_dirs
    if pointers.length > 0
      connect_4s = 0
      pointers.each { |pos,dir| connect_4s += 1 if root.check_line(dir) }
      return connect_4s > 0
    else
      return false
    end
  end


  def last_placed(col)
    #gets the slot that was placed last in the column
    i = @height - 1
    @columns[col].col_slots.each_with_index { |slot,index|
      last = @columns[col].col_slots[index-1]
      #sets the found index to wherever the column changes from filled to empty
      i = index-1 if slot.status.to_i == 0 && last.status.to_i > 0
    }
    return @columns[col].col_slots[i]
  end

end

class Column
  attr_reader :col_slots
  def initialize(x)
    #columns:
    #know which column they are (col)
    #knows which slots are in itself by their row (col_slots)
    @col = x
    height = 6
    @col_slots = Array.new(height)
    (0...height).each do |y| @col_slots[y] = Slot.new(x,y) end
  end

  def place(player)
    #tries to place a piece in the column
    placed = false
    @col_slots.each do |s|
      if s.status == 0
        s.fill(player)
        placed = true
        break
      end
    end
    return placed
  end

end

class Slot
  attr_reader :pos, :status
  @@slots = Hash.new

  def initialize(x,y)
    #Slots: know which slots have been made
    #know their position (pos)
    #knows what they contain (status)
    @pos = [x,y]
    @status = 0
    @@slots[@pos] = self
  end

  def match_dirs
    #returns hash: poistion that was found, val is direction it
    #took to get there
    dirs = [[+1,0],[+1,-1],[0,-1],[-1,-1],[-1,0],[-1,+1],[0,+1],[+1,+1]]
    bloom = Hash.new
    dirs.each do |dir| bloom[advance(dir)] = dir end
    #bloom key is the new pos, val is dir it took to get there
    on_board_bloom = bloom.select do |pos,dir| self.on_board(pos) end
    matches = on_board_bloom.select { |pos,dir|
      @@slots[pos].status == @status
    }
    return matches
  end

  def check_dir(dir)
    #gets the number of matches in a given direction
    matches = 0
    player = @status
    next_pos = advance(dir)
    next_slot = @@slots[next_pos]
    while on_board(next_pos) && @@slots[next_pos].status == player
      matches += 1
      next_pos = next_slot.advance(dir)
      next_slot = @@slots[next_pos] if on_board(next_pos)
    end
    return matches
  end

  def check_line(dir)
    #checks matches in the dir and reverse dir
    puts check_dir(dir)
    return false
  end

  def advance(dir)
    #naive advance in a given direction
    next_pos = [@pos[0]+dir[0],@pos[1]+dir[1]]
    return next_pos
  end

  def on_board(pos)
    #checks if a position is on the board
    height, width = 6,7
    return (0 <= pos[0] && pos[0] < width && 0 <= pos[1] && pos[1] < height)
  end

  def fill(player)
    @status = player
  end

  def slots
    @@slots
  end
end
