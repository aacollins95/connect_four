require "./lib/board"

RSpec.describe Board do
  describe "#add" do
    it "returns the sum of two numbers" do
      board = Board.new
      expect(board.columns.length).to eql(7)
      expect(board.columns[0].col_slots.length).to eql(6)
      expect(board.columns[0].col_slots[0].slots.length).to eql(42)
    end
  end
end

RSpec.describe Column do
  describe "#initialize" do
    it "initializes correctly" do
      column = Column.new(0)
      expect(column.col_slots.all? do |slot| slot.pos[0] == 0 end).to eql(true)
    end
  end
end

RSpec.describe Slot do
  describe "#initialize" do
    it "initializes correctly" do
      slot = Slot.new(0,0)
      expect(slot.pos).to eql([0,0])
    end
  end
end
