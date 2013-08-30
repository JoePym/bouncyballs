class Ball

  constructor: (x,y,vx,vy,game) ->
    @coords = [x,y]
    @velocity = [vx,vy]
    @radius = 10
    @game = game

  move: ->
    [x,y] = @coords
    [vx,vy] = @velocity
    newX = x + vx
    newY = y + vy
    @coords = [newX, newY]

  draw: ->
    @move()
    return true unless @game.inScreen(@coords[0], @coords[1])
    [x,y] = @game.translate(@coords[0], @coords[1])
    context = @game.ctx
    context.beginPath()
    context.arc(x, y, @radius, 0, 2 * Math.PI, false)
    context.fillStyle = 'green'
    context.fill()
    context.lineWidth = 5
    context.strokeStyle = '#003300'
    context.stroke()

window.Ball = Ball