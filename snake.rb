class Point < Struct.new(:x, :y)
	def +(other)
		Point.new(x + other.x, y + other.y)
	end
end

class Snake
	#directions expressed as Point delta
	LEFT = Point.new(-1,0)
	RIGHT = Point.new(1,0)
	UP = Point.new(0,-1)
	DOWN = Point.new(0,1)


	def initialize(shape = [Point.new(0,0), Point.new(1,0)])
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

end

if __FILE__ == $0
	s = Snake.new
	puts "#{s.next}"
	puts "The length is #{s.length}"
end