class ClientPool
  include Celluloid
  include Celluloid::Logger

  def initialize
    @clients = {}
  end

  def add(client)
    @clients[client.uuid] = client
    info "ClientPool: #{@clients.length} clients currently connected."
  end

  def remove(client)
    @clients.delete(client.uuid)
    info "ClientPool: #{@clients.keys.length} clients currently connected."
  end

  def broadcast(message)
    @clients.values.each do |c|
      c.transmit(message)
    end
  end
end
