class Ball

  constructor: (x, y, vx, vy, game) ->
    @originalCoords = [x, y]
    @coords = [x, y]
    @velocity = [vx, vy]
    @radius = 10
    @game = game

  move: (totalElapsed, frameElapsed) ->
    [x, y] = @originalCoords
    [vx, vy] = @velocity

    newX = x + (vx * totalElapsed * .01)
    newY = y + (vy * totalElapsed * .01)

    console.log("p", newX, newY)
    @coords = [newX, newY]

  draw: ->
    return true unless @game.inScreen(@coords[0], @coords[1])
    [x, y] = @game.translate(@coords[0], @coords[1])
    context = @game.ctx
    context.beginPath()
    context.arc(x, y, @radius, 0, 2 * Math.PI, false)
    context.fillStyle = 'green'
    context.fill()
    context.lineWidth = 5
    context.strokeStyle = '#003300'
    context.stroke()

window.Ball = Ball
