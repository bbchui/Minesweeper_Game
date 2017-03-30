require_relative 'tile'
require 'byebug'

class Board
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.default_grid
    board = Array.new(9) do
      Array.new(9) { Tile.new }
    end

    10.times do |bomb|
      pos = [rand(9),rand(9)]
      board[pos[0]][pos[1]] = Tile.new(true, false)
      adjacent = []
      (-1..1).each do |x|
        (-1..1).each do |y|
          adjacent << [pos[0] + x, pos[1] + y] unless (pos[0] + x) < 0 ||
            (pos[1] + y) < 0 || (pos[0] + x) > 8 || (pos[1] + y) > 8
        end
      end

      adjacent.each do |adj|
        # debugger
        tile = board[adj[0]][adj[1]]
        tile.bomb_count += 1 unless tile.nil?
      end
    end
    self.new(board)
  end

  # def adjacent(pos)
  #   arr = []
  #   (-1..1).each do |x|
  #     (-1..1).each do |y|
  #       arr << [pos[0] + x, pos[1] + y] unless x < 0 || y < 0
  #     end
  #   end
  #   arr
  # end

  def random_pos
    x = rand(9)
    y = rand(9)
    [x, y]
  end

  def render
    print "  "
    puts (0..8).to_a.join(" ")
    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(" ")}"
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
end
