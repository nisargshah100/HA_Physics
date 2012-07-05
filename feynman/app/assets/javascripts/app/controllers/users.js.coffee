class App.UsersNew extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #new_user_btn" : "renderPreferencesForm"
    "click input#new_user_detail" : "renderPersonalDetailsForm"
    "click input#signup_back" : "goBack"
    "blur #user_display_name" : "checkDisplayName"
    "blur #user_email" : "checkEmail"
    "click #submit_new_user" : "submitForm"

  checkDisplayName: (e) =>
    if $('input#user_display_name').val()
      $.ajax({
            type: "POST",
            url: "/api/v1/user_validators",
            data: { display_name: $('input#user_display_name').val() },
            success: (response) =>
              if response.length > 0
                $(".modal-body-errors").html @view('shared/errors')(response)
                $("div.hide").fadeIn('fast')
              else
                $(".modal-body-errors").html("")
      })

  checkEmail: (e) =>
    if $('input#user_email').val()
      $.ajax({
            type: "POST",
            url: "/api/v1/user_validators",
            data: { email: $('input#user_email').val() },
            success: (response) =>
              if response.length > 0
                $(".modal-body-errors").html @view('shared/errors')(response)
                $("div.hide").fadeIn('fast')
              else
                $(".modal-body-errors").html("")
      })

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

  submitForm: (e) =>
    @log "HI"
    email = $('input#user_email').val()
    display_name = $('input#user_display_name').val()

    $.ajax({
          type: "POST",
          url: "/api/v1/user_validators",
          data: { 
                  email: email,
                  display_name: display_name
                },
          success: (response) =>
            if response.length > 0 || !display_name || !email
              $(".modal-body-errors").html @view('shared/errors')(response) if response.length > 0
              $("div.hide").fadeIn('fast')
            else
              $('form#new_user').submit()
    })
