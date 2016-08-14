require 'Qt4'
require_relative 'point'

class Array
  # returns a 1-dimensional enumerator of (element, Point) pairs where the point is the 2d intex of the element
  def with_point_index
    Enumerator.new do |elements|
      self.each_with_index do |column, x|
        column.each_with_index do |element, y|
          elements <<  [element,Point.new(x,y)]
        end
      end
    end
  end
end

class Board
  def initialize(size_x, size_y)
    @SIZE_X=size_x
    @SIZE_Y=size_y
    @board_content = Array.new(size_x){ Array.new(size_y, :empty) }
  end

  #puts a fruit on a random empty field
  def placeRandomFruit
    empty_points = boardWithCoords
        .select { |e, coords| e == :empty }
    if empty_points.size != 0 then
      random_index = Random.rand(empty_points.size)
      point = empty_points.to_a[random_index][1]
      @board_content[point.x][point.y] = :fruit
    end
  end

  def paint(painter)
    paint_border(painter)
    painter.save
    painter.translate(1, 1)
    #draw in in-board coordinates
    painter.restore
  end

  private
    def paint_border(painter)
      border_width_px = (@SIZE_X + 2)
      border_height_px = (@SIZE_Y + 2)
      color = Qt::black

      painter.fillRect(0, 0, border_width_px, 1, color)
      painter.fillRect(0, 0, 1, border_height_px, color)
      painter.fillRect(border_width_px - 1, 0, 1, border_height_px, color)
      painter.fillRect(0, border_height_px - 1, border_width_px, 1, color)
    end

    # returns a 1-dimensional array of [element,points] pairs for all points on the board
    def boardWithCoords
      @board_content.with_point_index
    end

end
