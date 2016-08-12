require 'Qt4'

class Board
	def initialize(size_x, size_y, unit_size_px = 10)
		@unit_size_px = unit_size_px
		@SIZE_X=size_x
	  @SIZE_Y=size_y
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
end
