class App.ImagesNew extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #open_image_preview_modal" : "fetchImages"
    "submit .new_image"               : "saveImage"
    "click #submit_profile_image"     : "saveProfileImage"

  saveImage: (e) =>
    e.preventDefault()
    new App.Photo({ 
      image_url: $('.active').data('image')['url'], 
      width: $('.active').data('image')['width'], 
      height: $('.active').data('image')['height']
      }).save()

  saveProfileImage: (e) =>
    e.preventDefault()
    $.ajax({
          type: "PUT",
          url: "/api/v1/user_details/#{$('.user_meta').data('id')}",
          data: { 
                  token: $('.user_meta').data('token'),
                  attribute: 'image',
                  value: $('.active').data('image')['url']
                },
          success: (response) =>
            alert("HI!")
      }) 

  renderImages: (e, objects) =>
    @objects = objects
    $("#image_preview_modal").html @view('images/new')(@) 
    $($(".carousel-inner").children()[0]).addClass("active")

  fetchImages: (e) =>
    token = $('.user_meta').data('token')
    url = "/api/v1/authentications.json?provider=instagram&token=#{token}"
    $.getJSON(url, (data) => @getInstagramPhotos(e, data) )

  getInstagramPhotos: (e, data) =>
    @response = data[0].token
    url = "https://api.instagram.com/v1/users/#{data[0].uid}/media/recent"
    $.ajax({
              type: "GET",
              dataType: "jsonp",
              url: url,
              data: { access_token: "#{data[0].token}", count: 30 },
              success: (response) =>
                @renderImages(e, response.data)
          })

class App.ImagesIndex extends Spine.Controller
  constructor: ->
    super
    Photo.fetch()
    Photo.bind 'refresh', @render

  render: =>
    $("#images").html @template()

  template: ->
    @images = Photo.all()
    @log @images
    @view('images/index')(@)
