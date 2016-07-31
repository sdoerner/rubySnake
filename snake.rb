class Point < Struct.new(:x, :y)
end

class Snake
	def initialize(shape = [Point.new(0,0), Point.new(0,1)])
      @shape = shape
    end

	def length
		@shape.length
	end

end

if __FILE__ == $0
	s = Snake.new
	puts "The length is #{s.length}"
end