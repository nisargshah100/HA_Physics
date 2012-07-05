class App.DealsIndex extends Spine.Controller
  constructor: ->
    super
    @filterDeals()
    Deal.bind 'refresh', @render

  events:
    "click .open_event_modal" : "renderForm"
    "submit .new_event"       : "createEvent"
    "click .filter_deals"     : "filterDeals"

  renderForm: (action) =>
    deal = $(action.target).data()
    $("#event_modal").html @newEventForm(deal) # XXX ASK HOW TO BIND TO HTML LOAD
    $('#event_modal').modal()

  template: (deals) =>
    @deals = deals
    @view('deals/index')(@)

  filterDeals: (e) =>
    e.preventDefault() if e
    $.ajax({
          url: "/api/v1/deals",
          data: { 
                  token: $('.user_meta').data('token'),
                  zipcode: $('.deal_filter_zipcode').val()
                  radius: $('.deal_filter_radius').val()
                },
          success: (response) =>
            $("#deals").html @template(response)
    }) 

  newEventForm: (deal) =>
    @deal_id = deal.dealId
    @source = deal.source
    @view('events/new')(@)

  createEvent: (e) =>
    e.preventDefault()
    event = new App.Event({
                              description: $("#event_body").val(),
                              deal_id: $("#event_deal_id").val(),
                              source: $("#event_deal_source").val(),
                            }).save()

    $("#event_body").val("")
    $("#event_modal").modal("hide")

    $("#alert-bar").addClass('alert-success').text('Congratulations on posting your date!').hide()
    $("#alert-bar").slideDown().delay(3000).slideUp()
