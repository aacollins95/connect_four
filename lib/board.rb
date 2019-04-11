class Board
  attr_reader :columns
  def initialize
    width = 7
    @columns = Array.new
    (0...width).each do |i| @columns.push(Column.new(i)) end
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
  @@slots =[]

  def initialize(x,y)
    #Slots: know which slots have been made
    #know their position (pos)
    #knows what they contain (status)
    @pos = [x,y]
    @status = 0
    @@slots.push(self)
  end

  def fill(player)
    @status = player
  end

  def slots
    @@slots
  end
end
