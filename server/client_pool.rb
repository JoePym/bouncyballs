class ClientPool
  def initialize
    @clients = {}
  end

  def add(client)
    @clients[client.connection] = client
    puts "ClientPool: #{@clients.length} clients currently connected."
  end

  def client_by_ws(ws)
    @clients[ws]
  end

  def remove_by_ws(ws)
    @clients.delete(ws)
    puts "ClientPool: #{@clients.keys.length} clients currently connected."
  end

  def broadcast(message)
    @clients.values.each do |c|
      c.transmit(message)
    end
  end
end
