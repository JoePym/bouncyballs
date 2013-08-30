class Entity

  attr_reader :x, :y

  def initialize(x, y, dx, dy, time = Time.now)
    @id = SecureRandom.hex

    @x = x
    @y = y
    @dx = dx
    @dy = dy

    @color = "rgba(#{[rand(255), rand(255), rand(255), rand(0.5..1.0)].join(',')})"
    @tzero = time
  end

  def update(t)
    delta_t = t.to_f - @tzero.to_f
    @x = @x + (delta_t * @dx)
    @y = @y + (delta_t * @dy)
  end

  def state(t = Time.now)
    update(t)

    { id: @id,
      x: @x,
      y: @y,
      color: @color,
      dx: @dx,
      dy: @dy,
      color: @color }
  end

  def alive?
    world = Celluloid::Actor[:world]
    (@x > 0 && @y > 0) && (@x < world.width || @y < world.height)
  end
end
