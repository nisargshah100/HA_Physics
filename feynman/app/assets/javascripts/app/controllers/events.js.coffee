class App.Events extends Spine.Controller
  constructor: ->
    super

    @events()

    Event.fetch()
    Event.bind 'refresh', @render

  events: ->
    # $('#hello_button').live('click', @render)

  render: =>
    $("#events").html @template()

  template: ->
    @events = Event.all()
    @user_id = $('.user_meta').data('id')
    @location = $('.user_meta').data('location')

    if @location
      @view('short_events')(@)
    else
      @view('events')(@)