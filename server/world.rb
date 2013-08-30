class World
  include Celluloid

  def initialize
    @height = 10000
    @width = 10000

    @entities = []

    @life_check = Celluloid.every(1) do
      @entities.each do |entity|

      end
    end
  end

  def spawn(x = nil, y = nil, time = Time.now)
    if x.nil? && y.nil?
      x = rand(@width)
      y = rand(@height)
    end

    @entities << Entity.new(x, y, rand(-10..10), rand(-10..10), time)
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
