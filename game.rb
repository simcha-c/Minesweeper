require_relative 'board'
require "byebug"

class Game

  def initialize
    @board = Board.new(9)
  end

  def play
    until won? || lost?
      system "clear"
      @board.render
      pos = parse_pos(get_pos)
      action = get_action
      toggle_space(pos, action)
    end

    if won?
      @board.render
      puts "Congrats!"
    else
      @board.render
      puts "Sorry"
    end
  end

  def won?
    won = true
    (0...9).to_a.length.times do |row|
      (0...9).to_a.length.times do |col|
        tile = @board[[row,col]]
        if tile.value == "B" && tile.flagged == false
          won = false
        end
      end
    end
    won
  end

  def lost?
    (0...9).to_a.length.times do |row|
      (0...9).to_a.length.times do |col|
        tile = @board[[row,col]]
        if tile.value == "B" && tile.revealed
          return true
        end
      end
    end
    false
  end

  def get_pos
    puts "Enter a position (e.g. '1,2')"
    gets.chomp
  end

  def parse_pos(pos)
    pos.split(",").map(&:to_i)
  end

  def get_action
    puts "Reveal or flag (r/f)?"
    gets.chomp
  end

  def toggle_space(pos, action)
    if action == "f"
      @board[pos].toggle_flagged
    else
      @board.reveal_adj_rec(pos)
    end
  end

end

game = Game.new
game.play
