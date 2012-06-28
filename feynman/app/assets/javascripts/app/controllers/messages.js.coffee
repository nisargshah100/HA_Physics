class App.Messages extends Spine.Controller
  constructor: ->
    super
    Message.fetch()
    Message.bind 'refresh', @render

  events:
    "click .send_message" : "sendMessage"

  render: =>
    $("#messages").html @template()

  template: ->
    @messages = Message.all()
    @view('messages')(@)