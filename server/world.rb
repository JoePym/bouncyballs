class World
  include Celluloid

  def initialize
    @entities = []
  end

  def add(entity)
    @entities << entity
  end

  def current_state
    time = Time.now
    positions = @entities.map do |entity|
      entity.state(time)
    end

    { time: time.to_f,
      positions: positions }
  end
end
