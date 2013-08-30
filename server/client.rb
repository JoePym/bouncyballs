class Client
  attr_reader :uuid
  attr_reader :connection
  attr_reader :x
  attr_reader :y
  attr_reader :height
  attr_reader :width

  def initialize(connection)
    @uuid = SecureRandom.hex
    puts "New websocket client: #{@uuid}"
    @connection = connection
  end

  def handle(message)
    puts "#{@uuid} rcvd: #{message}"
    request = JSON.parse(message)
    send(request.fetch('command'), request.fetch('value'))
  end

  def connect(value)
    @x = value.fetch('x')
    @y = value.fetch('y')
    @height = value.fetch('height')
    @width = value.fetch('width')

    puts "#{@uuid}: position and dimensions set."
    transmit $world.current_state
  end

  def spawn(value)
    $world.spawn(value.fetch('x'), value.fetch('y'))
    $pool.broadcast $world.current_state
  end

  def transmit(message)
    @connection.send JSON.generate(message)
    puts "#{@uuid} send: #{message}"
  end

  def close
    $pool.remove(self)
    puts "#{@uuid}: closing #{self}"
    terminate
  end
end
