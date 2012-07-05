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
    recipient_id = $(e.target).data('user-id')
    $("#message_modal").html @form(recipient_id)

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

  form: (recipient_id) =>
    @view('messages/new')(recipient_id)