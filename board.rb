require 'Qt4'

class Board
	def initialize(unit_size_px)
		@unit_size_px = unit_size_px
		@SIZE_X=30
	  @SIZE_Y=30
	end

	def paint(painter)
		border_width_px = (@SIZE_X + 2) *  @unit_size_px
		border_height_px = (@SIZE_Y + 2) * @unit_size_px
		painter.setPen(Qt::green)
		color = Qt::black

		painter.fillRect(0, 0, border_width_px, @unit_size_px, color)
		painter.fillRect(0, 0, @unit_size_px, border_height_px, color)
		painter.fillRect(border_width_px - @unit_size_px, 0, @unit_size_px, border_height_px, color)
		painter.fillRect(0, border_height_px - @unit_size_px, border_width_px, @unit_size_px, color)
	end
end