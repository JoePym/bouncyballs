class ClientPool
  include Celluloid
  include Celluloid::Logger

  def initialize
    @clients = []
  end

  def add(client)
    @clients << client
  end

  def broadcast(message)
    message = JSON.dump(message)
    @clients.each do |c|
      c.transmit(message)
    end
  end
end
