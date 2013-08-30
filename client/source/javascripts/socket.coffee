class Socket
  constructor: (attrs, callback) ->
    @socket = new WebSocket("ws://localhost:3000")
    @socket.onopen = =>
      @socket.send(JSON.stringify({command: 'connect',value: attrs}))
    @socket.onmessage = callback

    @socket.onclose = @log
    @socket.onerror = @log

  send: (data) ->
    @socket.send(JSON.stringify(data))

  log: (e) ->
    console.log(e)

window.Socket = Socket
