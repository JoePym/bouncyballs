class Ball

  constructor: (x, y, vx, vy,color, game) ->
    @originalCoords = [x, y]
    @coords = [x, y]
    @velocity = [vx, vy]
    @color = color
    @radius = 10
    @game = game

  move: (totalElapsed, frameElapsed) ->
    [x, y] = @coords
    [vx, vy] = @velocity

    newX = x + (vx * frameElapsed)
    newY = y + (vy * frameElapsed)

    @coords = [newX, newY]

  draw: ->
    return true unless @game.inScreen(@coords[0], @coords[1])
    [x, y] = @game.translate(@coords[0], @coords[1])
    context = @game.ctx
    context.beginPath()
    context.arc(x, y, @radius, 0, 2 * Math.PI, false)
    context.fillStyle = @color
    context.fill()
    context.lineWidth = 5
    context.strokeStyle = 'black'
    context.stroke()

window.Ball = Ball
