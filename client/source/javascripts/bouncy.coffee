class Bouncy

  constructor: () ->
    @h =  $(window).height()
    @w = $(window).width()
    @left = 0
    @top = 0
    @balls = []
    canvas = $('canvas:first')[0]
    canvas.width = @w
    canvas.height = @h
    @ctx = canvas.getContext('2d')
    @connect()
    @_firstTickTime = performance.now()
    @_lastTickTime = performance.now()
    @_tickInterval = setInterval (=> @tick()), 10
    @setupHandlers()

  connect: () ->
    @socket = new Socket {x: 300, y: 400, height: @h, width: @w}, (msg) =>
      data = JSON.parse(msg.data)
      t = data.time
      currentTime = new Date().getTime()
      dt = currentTime - t
      @balls = []
      for position in data.positions
        x = position.x + (dt*position.dx/100)
        y = position.y + (dt*position.dy/100)
        @balls.push(new Ball(x,y,position.dx,position.dy,position.color, this))

  setupHandlers: () ->
    $("body").on "click", "canvas", (e) =>
      e.preventDefault()
      if e.pageX || e.pageY
        x = e.pageX
        y = e.pageY
      else
        x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
        y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop
      canvas = $('canvas:first')[0]
      x = x - canvas.offsetLeft
      y = y - canvas.offsetTop
      console.log([x,y])
      @socket.send({'command': 'spawn', 'value': {'x': x, 'y':y, 'time': new Date().getTime()/1000}})

  tick: ->
    @_tickTime = performance.now()
    @totalElapsed = @_tickTime - @_firstTickTime
    @frameElapsed = @_tickTime - @_lastTickTime
    @_lastTickTime = @_tickTime

    @move(@totalElapsed, @frameElapsed)
    @draw()

  move: (elapsed) ->
    ball.move(elapsed) for ball in @balls

  draw: ->
    @ctx.clearRect(0 ,0, @w , @h)
    ball.draw() for ball in @balls

  inScreen: (x,y) ->
    inX = (x  < (@left + @w)) && (x  > (@left))
    inY = (y  < (@top + @h)) && (y > (@top))
    inX && inY

  translate: (x,y) ->
    newX = x - @left
    newY = y - @top
    return [newX,newY]

window.Bouncy = Bouncy
