require_relative 'board'
require_relative 'canvas'
require_relative 'snake'
require_relative 'qtsnakepainter'
require_relative 'gamelogic'
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

        button = Qt::PushButton.new('Quit')
        button.connect(SIGNAL :clicked) { quit }
        point_label = Qt::Label.new("") {}

        @board = Board.new(42, 32)
        snakePainter = QtSnakePainter.new(Qt::blue)

        snake = Snake.new()
        @snake = snake

        @game_logic = GameLogic.new(@board,@snake, point_label)

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

        @timer = Qt::Timer.new
        @timer.setSingleShot(false)
        @timer.setInterval(150)
        @timer.connect(SIGNAL :timeout) do
          result,points = @game_logic.evaluateTurn
          if result == :lost
            puts "Lost game at #{points} points"
            quit
          end
          canvas.update
        end
        @timer.start

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

        def quit
          Qt::Application.instance.quit
        end

        def keyPressEvent(event)
          move = @keymap[event.key]
          if move != nil
            @snake.setDirection(move)
          end
          if event.key == Qt::Key_Q.to_i
            quit
          elsif event.key == Qt::Key_G.to_i
            @game_logic.growSnake
          elsif event.key == Qt::Key_F.to_i
            @board.placeRandomFruit
          elsif event.key == Qt::Key_P.to_i
            if @timer.isActive then
              @timer.stop
            else
              @timer.start
            end
          end
        end

        show
    end
    exec
end
