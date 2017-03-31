require_relative 'board'

class Game

  attr_reader :board

  def initialize(board = Board.default_grid)
    @board = board
  end

  def run
    play_turn until over?
  end

  def play_turn
    board.render
    puts "Pick a position."
    pos = gets.chomp
    choice = pos[0]
    pos = pos[1..-1]
    pos = pos.split(",").map(&:to_i)

    if choice == "f"
      flag(pos)
    elsif choice == "r"
      reveal_adj(pos)
    else
      puts "invalid guess"
    end
  end

  def flag(pos)
    @board[pos].flag
  end

  def over?
    count = 0
    board.grid.flatten.each do |el|
      if el.bomb? && el.revealed
        puts "you lose"
        return true
      end
      count += 1 unless el.revealed
    end
    if count == 10
      puts "you win"
      return true
    end
    false
  end

  def reveal_adj(pos)
    board[pos].reveal
    adj = adjacent(pos)
    if board[pos].bomb_count == 0
      adj.each do |tile|
        reveal_adj(tile) unless board[tile].revealed
      end
    end

  end

  def adjacent(pos)
    arr = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        arr << [pos[0] + x, pos[1] + y] unless (pos[0] + x) < 0 ||
          (pos[1] + y) < 0 || (pos[0] + x) > 8 || (pos[1] + y) > 8
      end
    end
    arr
  end

end

game = Game.new
game.run
