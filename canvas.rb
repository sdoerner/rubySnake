class Canvas < Qt::Widget

  def initialize(width, height, painters)
    super()
    @size = Qt::Size.new(width, height)
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
    @painters.each { |p| p.paint(painter)}
    painter.end
  end

end
