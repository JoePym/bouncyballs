# Calibration

class window.CalibrationPage

  constructor: ->

    @$calibrator = $("#calibrator")
    @$dragger = @$calibrator.find("#dragger")

    @x = @y = 0
    @width = @$calibrator.outerWidth()
    @height = @$calibrator.outerHeight()

    $("#calibrate").click (event) =>
      event.preventDefault()
      console.log "click"

      $(".jumbotron").hide()
      @$calibrator.show()

    # Constraints on the draggable:
    @$dragger.draggable
      stop: (event, ui) => @drag(event, ui)

    @$calibrator.find("a").click (event) => @done(event)

    @resize()
    $(window).resize => @resize()

  resize: ->
    @width = @$calibrator.outerWidth()
    @height = @$calibrator.outerHeight()

    x1 = -(@$dragger.outerWidth() - @$calibrator.outerWidth())
    y1 = -(@$dragger.outerHeight() - @$calibrator.outerHeight())

    @$dragger.draggable("option", "containment", [x1, y1, 0, 0])
    @$dragger.click()

  drag: (event, ui) ->
    console.log("DRAG", ui)
    @x = -ui.position.left
    @y = -ui.position.top

    @$calibrator.find("p").text("#{@x}, #{@y}")

  done: (event) ->
    event.preventDefault()
    window.location = "/game.html?x=#{@x}&y=#{@y}&w=#{@width}&h=#{@height}"
