require_relative 'board'
require_relative 'canvas'
require 'Qt4'


Qt::Application.new(ARGV) do
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