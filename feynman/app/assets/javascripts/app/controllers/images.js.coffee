class App.ImagesIndex extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #open_message_modal" : "renderForm"
    "submit .new_message"       : "sendMessage"

  renderForm: (e) =>
    $("#message_modal").html @form()    

  sendMessage: (e) =>
    e.preventDefault()
    # message = App.Message.fromForm(e.target).save()
    message = new App.Message(body: $("#message_body").val(), recipient_id: $("#message_recipient_id").val()).save()
    @log message
    $("#message_body").val("")
    $("#message_modal").modal("hide")

  form: =>
    @recipient_id = $(".profile_meta").data("id")
    @view('new_message')(@)