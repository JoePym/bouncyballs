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

  def uuid(value)
    @uuid = value
    info "uuid set to #{value} for #{self}"
  end

  def transmit(message)
    @connection << message
  end

  def close
    terminate
  end
end
