class World
  include Celluloid

  def initialize
    @height = 10000
    @width = 10000

    @entities = []
  end

  def spawn(x, y)
    @entities << Entity.new(x, y, rand(-10..10), rand(-10..10))
  end

  def current_state
    time = Time.now
    positions = @entities.map do |entity|
      entity.state(time)
    end

    { time: time.to_f*1000,
      positions: positions }
  end
end
