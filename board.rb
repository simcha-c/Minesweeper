require_relative 'tile'
require 'byebug'

class Board

  POSITION_DIFF = [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]]

  def self.generate_tile_grid(length)
    grid = Array.new(length) { Array.new(length) {Tile.new} }

  end

  def setup_grid
    bomb_positions = generate_bomb_positions(9)

    bomb_positions.each { |pos| self[pos].value = 'B' }
    setup_non_bomb_tiles
  end

  def generate_bomb_positions(num_bombs)
    bomb_positions = []

    while bomb_positions.length < num_bombs
      row = (0...@length).to_a.sample
      col = (0...@length).to_a.sample
      bomb_positions << [row, col] unless bomb_positions.include?([row, col])
    end

    bomb_positions
  end

  def setup_non_bomb_tiles
    (0...@grid.length).each do |row|
      (0...@grid[row].length).each do |col|
        tile = self[[row, col]]
        tile.value = num_adj_bombs([row, col]) unless tile.value == "B"
      end
    end
  end

  def num_adj_bombs(pos)
    counter = 0
    POSITION_DIFF.each do |diff|
      adj_pos = [pos[0] + diff[0], pos[1] + diff[1]]
      if in_bounds?(adj_pos) && self[adj_pos].value == "B"
        counter += 1
      end
    end

    counter
  end

  def reveal_adj_rec(pos)
    sum = num_adj_bombs(pos)

    if self[pos].flagged || self[pos].revealed
      return self[pos].to_s
    elsif sum > 0
      self[pos].revealed = true
      return sum #num_adj_bombs(pos)
    end

    self[pos].revealed = true

    POSITION_DIFF.each do |diff|
      new_pos = [pos[0] + diff[0], pos[1] + diff[1]]
      if in_bounds?(new_pos)
        reveal_adj_rec(new_pos)
      end
    end
  end

  def in_bounds?(pos)
    pos[0] >= 0 && pos[1] >= 0 && pos[0] < @length && pos[1] < @length
  end

  def initialize(length)
    @length = length
    @grid = Board.generate_tile_grid(length)
    setup_grid
  end

  def render
    print "  #{(0...@length).to_a.join(" ")}"
    puts
    (0...@length).each do |row|
      print "#{row} "

      (0...@length).each do |col|
        print "#{@grid[row][col].to_s} "
      end
      puts
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, val)
    self[pos] = val
  end

end
