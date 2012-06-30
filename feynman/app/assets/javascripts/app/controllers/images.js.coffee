class App.ImagesNew extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #open_image_preview_modal" : "fetchImages"
    "submit .new_image"               : "saveImage"

  saveImage: (e) =>
    e.preventDefault()
    new App.Image({ 
      image_url: $('.active').data('image')['url'], 
      width: $('.active').data('image')['width'], 
      height: $('.active').data('image')['height']
      }).save()

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
    Image.fetch()
    Image.bind 'refresh', @render

  render: =>
    $("#images").html @template()

  template: ->
    @images = Image.all()
    @view('images/index')(@)
