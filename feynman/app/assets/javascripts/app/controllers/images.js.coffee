class App.ImagesNew extends Spine.Controller
  constructor: -> 
    super

  events:
    "click #open_image_preview_modal" : "fetchImages"
    "submit .new_image"               : "saveImage"

  saveImage: (e) =>
    e.preventDefault()
    alert('hi')

  renderImages: (e) =>
    $("#image_preview_modal").html @view('new_image')(@)   

  fetchImages: (e) =>
    @renderImages(e)
    token = $('.user_meta').data('token')
    url = "/api/v1/authentications.json?provider=instagram&token=#{token}"
    $.getJSON(url, (data) => @getInstagramPhotos(data) )

  getInstagramPhotos: (data) =>
    @response = data[0].token
    url = "https://api.instagram.com/v1/users/#{data[0].uid}/media/recent"
    $.ajax({
              type: "GET",
              dataType: "jsonp",
              url: url,
              data: { access_token: "#{data[0].token}", count: 30 },
              success: (response) ->
                objects = response.data
                for object in objects
                  console.log object.images.low_resolution.url
                  $(".carousel-inner").append("<div class='item'><img src='#{object.images.low_resolution.url}'></img></div>")
                  $($(".carousel-inner").children()[0]).addClass('active')
          })