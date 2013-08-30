require 'em-websocket'

Dir[File.join(File.dirname(__FILE__), '*.rb')].each{|file| require file }

EM.run {
  puts "Starting BouncyBall server..."

  $pool = ClientPool.new
  $world = World.new
  $world.spawn()

  EM.add_periodic_timer(2) do
    $world.cleanup
  end

  puts 'ClientPool created and registered.'

  EM::WebSocket.run(:host => "0.0.0.0", :port => 3000) do |ws|
    ws.onopen { |handshake|
      client = Client.new(ws)
      $pool.add(client)
    }

    ws.onclose {
      $pool.remove_by_ws(ws)
    }

    ws.onmessage { |msg|
      client = $pool.client_by_ws(ws)
      client.handle(msg)
    }
  end
}
