require_relative 'snake'
require 'Qt4'

class QtSnakePainter
  def initialize(unit_px_size, color)
    @unit_px_size = unit_px_size
    @color = color
  end

  def paintSnake(snake, painter)
    snake.shape.each do |snakePart|
      coords = [snakePart.x, snakePart.y, 1, 1].map { |coord| coord * @unit_px_size }
      painter.fillRect(*coords, @color)
    end
  end
end
