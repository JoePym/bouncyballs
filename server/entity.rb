class Entity
  include Celluloid

  def initialize(x, y, dx, dy)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
  end

  def update(t)
  end

  def state(t)
    update

    { x: @x,
      y: @y,
      dx: @dx,
      dy: @dy }
  end
end
