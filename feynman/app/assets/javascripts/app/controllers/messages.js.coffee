class App.MessagesIndex extends Spine.Controller
  constructor: ->
    super
    Message.fetch()
    Message.bind 'refresh', @render

  render: =>
    $("#messages").html @template()

  template: ->
    @messages = Message.all()
    @view('messages/index')(@)

class App.MessagesNew extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #open_message_modal" : "renderForm"
    "submit .new_message"       : "sendMessage"

  renderForm: (e) =>
    @id = $(e.target).data('user-id')
    @display_name = $(e.target).data('display-name')
    $("#message_modal").html @view('messages/new')(@)

  sendMessage: (e) =>
    e.preventDefault()
    # message = App.Message.fromForm(e.target).save()
    message = new App.Message({ 
                                body: $("#message_body").val(),
                                recipient_id: $("#message_recipient_id").val()
                              }).save()
    @log message
    $("#message_body").val("")
    $("#message_modal").modal("hide")