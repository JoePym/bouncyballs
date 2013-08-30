class Entity
  include Celluloid

  def initialize(x, y, dx, dy)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @t_zero = Time.now
  end

  def update(t)
  end

  def state(t = Time.now)
    update(t)

    { x: @x,
      y: @y,
      dx: @dx,
      dy: @dy }
  end
end
