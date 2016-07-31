class Point < Struct.new(:x, :y)
	def +(other)
		Point.new(x + other.x, y + other.y)
	end

	def to_s
		"(#{x}, #{y})"
	end
end

class Snake
	#directions expressed as Point delta
	LEFT = Point.new(-1,0)
	RIGHT = Point.new(1,0)
	UP = Point.new(0,-1)
	DOWN = Point.new(0,1)

	attr_writer :direction


	def initialize(shape = [Point.new(0,0)])
      @shape = shape
      @direction = RIGHT
    end

	def length
		@shape.length
	end

    #returns the next point the snake would go to
	def next
		if @shape.length == 0
			Point.new(0,0)
		else
			@shape[-1] + @direction
		end
	end

    #moves the snake to the next field, not changing its size
	def move
		@shape << self.next
		@shape = @shape.drop(1)
	end

	#grows the snake by advancing to the next field but not cutting its tail
	def grow
		@shape << self.next
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