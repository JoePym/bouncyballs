class ClientPool
  include Celluloid
  include Celluloid::Logger

  def initialize
    @clients = []
  end

  def add(client)
    @clients << client
  end

  def remove(client)
    @clients.delete(client)
  end

  def broadcast(message)
    @clients.each do |c|
      c.transmit(message)
    end
  end
end
