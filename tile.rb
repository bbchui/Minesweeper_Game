require 'byebug'
class Tile

  attr_accessor :bomb_count
  attr_reader :revealed

  def initialize(bomb = false, revealed = false)
    @bomb = bomb
    @revealed = revealed
    @flagged = false
    @bomb_count = 0
  end

  def reveal
    @revealed = true
  end

  def bomb?
    @bomb
  end

  def flag
    @flagged = @flagged ? false : true
  end

  def to_s
    return "F" if @flagged
    return "*" unless @revealed
    return "#{bomb_count}" unless @bomb_count == 0
    "_"
  end
end
