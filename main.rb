require_relative 'board'
require 'Qt4'

class Canvas < Qt::Widget

	def initialize(width, height, painters)
		super()
		@size = Qt::Size.new(width, height)
		@painters = painters
	end


	def minimumSizeHint()
	  return @size
	end

	def sizeHint()
	  return @size
	end

	def paintEvent(event)
		painter = Qt::Painter.new(self)
		@painters.each { |p| p.paint(painter)}
	  painter.end
	end
end


Qt::Application.new(ARGV) do
	#Qt.debug_level = Qt::DebugLevel::High
    Qt::Widget.new do

        self.window_title = 'Snake Game with QtRuby!'
        resize(500, 500)
    
        button = Qt::PushButton.new('Quit') do
            connect(SIGNAL :clicked) { Qt::Application.instance.quit }
        end

        board = Board.new(40, 30)
        canvas = Canvas.new(450, 450, [board])
        
        self.layout = Qt::VBoxLayout.new do
            add_widget(button, 0, Qt::AlignRight)
            add_widget(canvas, 0, Qt::AlignCenter)
        end
        show
    end
    exec
end