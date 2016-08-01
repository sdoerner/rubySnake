require_relative 'board'
require_relative 'canvas'
require_relative 'snake'
require_relative 'qtsnakepainter'
require 'Qt4'


Qt::Application.new(ARGV) do
    Qt::Widget.new do
        @keymap = {
          Qt::Key_Left.to_i => Snake::LEFT,
          Qt::Key_Right.to_i => Snake::RIGHT,
          Qt::Key_Up.to_i => Snake::UP,
          Qt::Key_Down.to_i => Snake::DOWN
        }
        self.window_title = 'Snake Game with QtRuby!'
        resize(500, 500)
    
        button = Qt::PushButton.new('Quit') do
            connect(SIGNAL :clicked) { Qt::Application.instance.quit }
        end

        SCALE = 10
        board = Board.new(42, 32, SCALE)
        snakePainter = QtSnakePainter.new(SCALE, Qt::blue)

        snake = Snake.new()
        @snake = snake
        snake.grow
        snake.grow

        # bind qt painter to our snake
        snakeBoundPainter = Class.new do
          self.define_singleton_method(:paint) do |painter|
            painter.save
            painter.translate(SCALE, SCALE)
            snakePainter.paintSnake(snake, painter)
            painter.restore
          end
        end

        canvas = Canvas.new(450, 450, [board, snakeBoundPainter])

        timer = Qt::Timer.new
        timer.setSingleShot(false)
        timer.setInterval(1000)
        timer.connect(SIGNAL :timeout) do
          snake.move
          canvas.update
        end
        timer.start
        
        

        self.layout = Qt::VBoxLayout.new do
            add_widget(button, 0, Qt::AlignRight)
            add_widget(canvas, 0, Qt::AlignCenter)
        end

        def keyPressEvent(event)
          puts "event 2"
          move = @keymap[event.key]
          if move != nil
            puts "sending move: #{move}"
            @snake.direction=move
          end
        end

        show
    end
    exec
end