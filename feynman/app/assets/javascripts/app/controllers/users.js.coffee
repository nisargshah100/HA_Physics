class App.UsersNew extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #new_user_btn" : "renderPreferencesForm"
    "submit #new_user_detail" : "renderPersonalDetailsForm"

  renderPreferencesForm: (e) =>
    e.preventDefault()
    $("#new_user_modal").html @preferencesForm() # XXX ASK HOW TO BIND TO HTML LOAD
    $('#new_user_modal').modal()

  renderPersonalDetailsForm: (e) =>
    e.preventDefault()
    user_detail = UserDetail.fromForm(e.target)
    if msg = user_detail.validate()
      $("#new_user_modal").html @preferencesForm()
      @log msg
    else
      $("#new_user_modal").html @personalDetailsForm(user_detail) # XXX ASK HOW TO BIND TO HTML LOAD

  preferencesForm: =>
    @view('users/preferences') # XXX ASK HOW TO CONDITIONALLY BRING BACK OLD FORM ELEMENTS.

  personalDetailsForm: (user_preferences) =>
    @user_preferences_json = JSON.stringify(user_preferences)
    @view('users/personal_details')(@)

  saveImage: (e) =>
    e.preventDefault()
    new App.Photo({ 
      image_url: $('.active').data('image')['url'], 
      width: $('.active').data('image')['width'], 
      height: $('.active').data('image')['height']
      }).save()