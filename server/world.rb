class World
  attr_reader :width
  attr_reader :height

  def initialize
    @height = 10000
    @width = 10000

    @entities = []
  end

  def spawn(x = nil, y = nil, time = Time.now)
    if x.nil? && y.nil?
      x = rand(@width)
      y = rand(@height)
    end

    @entities << Entity.new(x, y, rand(-20..20), rand(-20..20), time)
  end

  def cleanup
    puts 'World running cleanup...'
    need_to_transmit = false

    @entities.each do |entity|
      if !entity.alive?
        need_to_transmit = true
        puts "Removing entity #{entity} at #{entity.x} x #{entity.y}"
        @entities.delete(entity)
      end
    end

    $pool.broadcast($world.current_state) if need_to_transmit
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
