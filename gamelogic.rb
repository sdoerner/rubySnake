require_relative 'board'
require_relative 'snake'

class GameLogic

  def initialize(board, snake, points_label)
    @board = board
    @snake = snake
    @points = 0
    @points_label = points_label
  end

  def evaluateTurn
    next_snake_point = @snake.next
    next_field = @board.getField(next_snake_point)
    case next_field
    when :wall
      [:lost,@points]
    when :fruit
      add_points
      @board.setField(next_snake_point, :empty)
      @snake.move
    when :empty
      @snake.move
    else
      raise "Unexpected board content #{next_field}"
    end
  end

  def add_points(points_to_add = 1)
    @points += points_to_add
    @points_label.setText(@points.to_s)
  end
end
