require 'rubygems'
require 'bundler/setup'
require 'reel'
require 'logger'
require 'json'
require 'pry'

# Include all other files.
Dir[File.join(File.dirname(__FILE__), '*.rb')].each{|file| require file }

# Set up logging.
# Celluloid.logger = ::Logger.new(File.join(File.dirname(__FILE__), 'log', 'server.log'))

class GameServer < Reel::Server
  include Celluloid::Logger

  def initialize(host = "127.0.0.1", port = 3000)
    info "Starting BouncyBall server on #{host}:#{port}..."

    clientpool = ClientPool.new
    Celluloid::Actor[:clientpool] = clientpool

    world = World.new
    Celluloid::Actor[:world] = world
    Celluloid::Actor[:world].spawn()

    info 'ClientPool created and registered.'
    super(host, port, &method(:on_connection))
  end

  def on_connection(connection)
    while request = connection.request
      case request
      when Reel::Request
        info "New HTTP request."
        handle_request(request)
      when Reel::WebSocket
        info "New Websocket request."
        handle_websocket(request)
      end
    end
  end

  def handle_websocket(socket)
    client = Client.new(socket)
    Celluloid::Actor[:clientpool].add(client)
  end

  def handle_request(request)
    request.respond :ok, "You should be using websockets..."
  end

end

GameServer.run
