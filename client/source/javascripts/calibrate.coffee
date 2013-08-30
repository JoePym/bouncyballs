# Calibration

$ -> new CalibrationPage()

class CalibrationPage

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

    x1 = -(@$dragger.outerWidth() - @$calibrator.outerWidth())
    y1 = -(@$dragger.outerHeight() - @$calibrator.outerHeight())

    # Constraints on the draggable:
    @$calibrator.find("#dragger").draggable
      containment: [x1, y1, 0, 0]
      stop: (event, ui) => @drag(event, ui)

    @$calibrator.find("a").click (event) => @done(event)

  drag: (event, ui) ->
    console.log("DRAG", ui)
    @x = -ui.position.left
    @y = -ui.position.top

  done: (event) ->
    event.preventDefault()
    window.location = "/game.html?x=#{@x}&y=#{@y}&w=#{@width}&h=#{@height}"
