require_relative 'snake'
require 'Qt4'

class QtSnakePainter
  def initialize(color)
    @color = color
  end

  def paintSnake(snake, painter)
    snake.shape.each do |snakePart|
      painter.fillRect(snakePart.x, snakePart.y, 1, 1, @color)
    end
  end
end
