require_relative 'board'
require_relative 'snake'

class GameLogic

  def initialize(board, snake, points_label)
    @board = board
    @snake = snake
    @points = 0
    @points_label = points_label

    @snake.shape.each do |p|
      @board.setField(p, :snake)
    end
    @snake.grow
    @snake.grow
    @snake.grow
    @board.placeRandomFruit
  end

  def evaluateTurn
    next_snake_point = @snake.next
    next_field = @board.getField(next_snake_point)
    case next_field
    when :wall, :snake
      [:lost,@points]
    when :fruit
      add_points
      @board.setField(next_snake_point, :empty)
      growSnake
      @board.placeRandomFruit
    when :empty
      moveSnake
    else
      raise "Unexpected board content #{next_field}"
    end
  end

  def moveSnake
    old_tail, new_head = @snake.move
    @board.setField(old_tail, :empty)
    @board.setField(new_head, :snake)
  end

  def growSnake
    new_field = @snake.grow
    @board.setField(new_field, :snake)
  end

  def add_points(points_to_add = 1)
    @points += points_to_add
    @points_label.setText(@points.to_s)
  end
end
