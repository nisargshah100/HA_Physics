class App.UserDetail extends Spine.Model
  @configure 'UserDetail', "gender", "gender_preference", "age_range_lower", "age_range_upper", "zipcode"
  @extend Spine.Model.Ajax

  @url: => 
    # @token = $('.user_meta').data('token')
    # url = "/api/v1/messages.json?token=#{@token}"

  validate: ->
    errors = []
    errors.push "Please enter a zipcode" unless @zipcode
    errors.push "Zipcode must be 5 digits" unless @zipcode.match(/^\d{5}$/)
    errors unless errors.length == 0

window.UserDetail = App.UserDetail

    # "user_id"
    # "image_url"
    # "employment"
    # "education"
    # "faith"
    # "faith_level"
    # "political_affiliation"
    # "political_affiliation_level"
    # "race"
    # "children_preference"
    # "exercise_level"
    # "drinking_level"
    # "smoking_level"
    # "created_at"
    # "updated_at"
    # "latitude"
    # "longitude"
    # "city"
    # "state"
    # "country"
    # "height"