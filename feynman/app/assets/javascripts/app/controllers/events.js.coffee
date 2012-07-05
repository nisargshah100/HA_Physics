class App.Events extends Spine.Controller
  constructor: ->
    super
    Event.fetch()
    Event.bind 'refresh', @render

  events:
    "click .remove_date" : "removeDate"

  render: =>
    $("#events").html @template()

  template: =>
    @events = Event.all()
    @user_id = $('.user_meta').data('id')
    @location = $('.user_meta').data('location')

    if @location
      @view('events/index_summary')(@)
    else
      @view('events/index')(@)

  removeDate: (e) =>
    e.preventDefault()
    id = $(e.target).data('id')

    $.ajax({
          url: "/api/v1/events/#{id}",
          type: "PUT",
          data: { 
                  token: $('.user_meta').data('token'),
                },
          success: (response) =>
            $(e.target).closest('.event').hide()
    }) 