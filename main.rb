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
        point_label = Qt::Label.new("") {}
        @point_label = point_label
        @points = 0

        @board = Board.new(42, 32)
        snakePainter = QtSnakePainter.new(Qt::blue)

        snake = Snake.new()
        @snake = snake
        snake.grow
        snake.grow

        # bind qt painter to our snake
        snakeBoundPainter = Class.new do
          self.define_singleton_method(:paint) do |painter|
            painter.save
            painter.translate(1, 1)
            snakePainter.paintSnake(snake, painter)
            painter.restore
          end
        end

        SCALE = 10
        canvas = Canvas.new(450, 450, SCALE, [@board, snakeBoundPainter])

        timer = Qt::Timer.new
        timer.setSingleShot(false)
        timer.setInterval(300)
        timer.connect(SIGNAL :timeout) do
          snake.move
          canvas.update
        end
        timer.start

        self.layout = Qt::VBoxLayout.new do
            hLayout = Qt::Widget.new do
              self.layout = Qt::HBoxLayout.new do
                add_widget(Qt::Label.new("Points: "), 0, Qt::AlignCenter)
                add_widget(point_label, 0, Qt::AlignCenter)
                add_widget(button, 0, Qt::AlignCenter)
              end
            end
            add_widget(hLayout, 0, Qt::AlignRight)
            add_widget(canvas, 0, Qt::AlignCenter)
        end

        def add_points(points_to_add = 1)
          @points += points_to_add
          @point_label.setText(@points.to_s)
        end

        def keyPressEvent(event)
          puts "event 2"
          move = @keymap[event.key]
          if move != nil
            puts "sending move: #{move}"
            @snake.direction=move
          end
          if event.key == Qt::Key_Q.to_i
            @snake.grow
          end
          if event.key == Qt::Key_F.to_i
            puts "placing fruit"
            @board.placeRandomFruit
          end
        end

        show
    end
    exec
end
