class Point < Struct.new(:x, :y)
  def +(other)
    Point.new(x + other.x, y + other.y)
  end

  def to_s
    "(#{x}, #{y})"
  end
end
