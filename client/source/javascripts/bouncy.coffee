class Bouncy

  constructor: () ->
    @canvasDimensions = [300,300]
    @bodyDimensions = [1000,1000]
    @left = 300
    @top = 400
    @balls = []
    canvas = $('canvas:first')[0]
    @ctx = canvas.getContext('2d')
    @draw()

  pushBall: (x,y,vx,vy) ->
    @balls.push(new Ball(x,y,vx,vy,this))

  draw: ->
    @ctx.clearRect(0 ,0, 300 , 300)
    ball.draw()  for ball in @balls
    window.setTimeout(->
      window.currentBouncy.draw()
    100)

  inScreen: (x,y) ->
    console.log [x,y]
    inX = (x  < (@left + @canvasDimensions[0])) && (x  > (@left))
    inY = (y  < (@top + @canvasDimensions[1])) && (y > (@top))
    inX && inY

  translate: (x,y) ->
    newX = x - @left
    newY = y - @top
    return [newX,newY]

$(document).ready ->
  window.currentBouncy = new Bouncy