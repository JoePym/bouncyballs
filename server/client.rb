class Client
  include Celluloid
  include Celluloid::Logger

  attr_reader :uuid
  attr_reader :connection
  attr_reader :x
  attr_reader :y
  attr_reader :height
  attr_reader :width

  def initialize(connection)
    @uuid = SecureRandom.hex
    info "New websocket client: #{@uuid}"
    @pool = Celluloid::Actor[:clientpool]
    @connection = connection
    async.open
  end

  def open
    loop do
      info "#{@uuid}: waiting for message..."
      message = @connection.read # Blocks and waits here for the next message.
      info "#{@uuid} rcvd: #{message}"
      request = JSON.parse(message)
      send(request.fetch('command'), request.fetch('value'))
    end
  end

  def connect(value)
    @x = value['x']
    @y = value['y']
    @height = value['height']
    @width = value['width']

    info "#{@uuid}: position and dimensions set."
    transmit Celluloid::Actor[:world].current_state
  end

  def transmit(message)
    @connection << JSON.generate(message)
    info "#{@uuid} send: #{message}"
  end

  def close
    terminate
  end
end
