require_relative 'point'

class Snake
  # directions expressed as Point delta
  LEFT = Point.new(-1,0)
  RIGHT = Point.new(1,0)
  UP = Point.new(0,-1)
  DOWN = Point.new(0,1)

  attr_reader :shape


  def initialize(shape = [Point.new(0,0)])
      @shape = shape
      @direction = RIGHT
    end

  def length
    @shape.length
  end

  def setDirection(move)
    # prevent changing direction to the opposite
    sum = move + @direction
    if (sum.x != 0 || sum.y != 0) then
      @direction = move
    end
  end

  # returns the next point the snake would go to
  def next
    if @shape.length == 0
      Point.new(0,0)
    else
      @shape[-1] + @direction
    end
  end

  # moves the snake to the next field, not changing its size
  # returns [old field, new field] for the old and new shape of the snake
  def move
    next_head = self.next
    old_tail = @shape[0]
    @shape << next_head
    @shape = @shape.drop(1)
    [old_tail,next_head]
  end

  # grows the snake by advancing to the next field but not cutting its tail
  # returns the newly added field
  def grow
    next_head= self.next
    @shape << next_head
    next_head
  end

  def to_s
    "Snake: [#{@shape.join(", ")}]"
  end
end

if __FILE__ == $0
  s = Snake.new
  s.move
  puts s
  s.grow
  puts s
  s.direction = Snake::DOWN
  3.times { s.move }
  puts s
end
