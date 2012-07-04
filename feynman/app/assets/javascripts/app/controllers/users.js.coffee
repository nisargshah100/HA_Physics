class App.UsersNew extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #new_user_btn" : "renderPreferencesForm"
    "click input#new_user_detail" : "renderPersonalDetailsForm"
    "click input#signup_back" : "goBack"

  renderPreferencesForm: (e) =>
    e.preventDefault()
    $("#new_user_modal").html @preferencesForm() # XXX ASK HOW TO BIND TO HTML LOAD
    $('#new_user_modal').modal()

  goBack: (e) =>
    e.preventDefault()
    @user_preferences = $('#user_user_preferences').val()
    @log @user_preferences
    $("#new_user_modal").html @preferencesForm(@user_preferences)

  renderPersonalDetailsForm: (e) =>
    e.preventDefault()
    user_detail = UserDetail.fromForm($('form#new_user_detail'))
    if msg = user_detail.validate()
      @log msg
      $(".modal-body-errors").html @view('shared/errors')(msg)
      $("div.hide").fadeIn('fast')
    else
      $("#new_user_modal").html @personalDetailsForm(user_detail)

  preferencesForm: (user_preferences="{}") =>
    @user_preferences = JSON.parse(user_preferences)
    @view('users/preferences')(@)

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