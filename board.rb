require 'Qt4'
require_relative 'point'

class Board
	def initialize(size_x, size_y, unit_size_px = 10)
		@unit_size_px = unit_size_px
		@SIZE_X=size_x
	  @SIZE_Y=size_y
    @board_content = Array.new(size_x){ Array.new(size_y, :empty) }
	end

  #puts a fruit on a random empty field
  def placeRandomFruit
    empty_points = boardWithCoords
        .flatten(1)
        .keep_if { |e| e[0] == :empty }
        .map { |e| e[1] }
    point = Random.rand(empty_points.size)
    @board_content[point.x][point.y] = :fruit
  end

	def paint(painter)
		border_width_px = (@SIZE_X + 2) *  @unit_size_px
		border_height_px = (@SIZE_Y + 2) * @unit_size_px
		color = Qt::black

		painter.fillRect(0, 0, border_width_px, @unit_size_px, color)
		painter.fillRect(0, 0, @unit_size_px, border_height_px, color)
		painter.fillRect(border_width_px - @unit_size_px, 0, @unit_size_px, border_height_px, color)
		painter.fillRect(0, border_height_px - @unit_size_px, border_width_px, @unit_size_px, color)
	end

  private
    # returns a 2-dimensional array of [element,points] pairs for all points on the board
    def boardWithCoords
      @board_content.map.with_index do |column, x|
        column.map.with_index do |element, y|
          [element, Point.new(x,y)]
        end
      end
    end

end
