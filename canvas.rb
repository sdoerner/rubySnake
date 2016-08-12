class Canvas < Qt::Widget

  def initialize(width, height, scale, painters)
    super()
    @size = Qt::Size.new(width, height)
    @scale = scale
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
    painter.scale(@scale, @scale)
    @painters.each { |p| p.paint(painter)}
    painter.end
  end

end
