class App.ImagesNew extends Spine.Controller
  constructor: -> 
    super
    
  events:
    "click #open_image_preview_modal" : "getInstagramPhotos"
    "submit .new_image"               : "saveImage"
    "click #submit_profile_image"     : "saveProfileImage"

  saveImage: (e) =>
    e.preventDefault()

    $.ajax({
      type: "POST",
      url: "/api/v1/images.json",
      data: { 
        token: $('.user_meta').data('token'), 
        image_url: $('.active').data('image')['url'], 
        width: $('.active').data('image')['width'], 
        height: $('.active').data('image')['height']
      },
      success: (response) =>
        Photo.trigger 'create', response if response
    })

  saveProfileImage: (e) =>
    e.preventDefault()
    $.ajax({
      type: "PUT",
      url: "/api/v1/user_details/#{$('.user_meta').data('id')}",
      data: { 
        token: $('.user_meta').data('token'),
        user_detail: { image_url: $('.active').data('image')['url'] }
      },
      success: (response) =>
        @log response
        $('img.profile_img').attr('src', response.image_url)
    }) 


  renderImages: (e, objects) =>
    @objects = objects
    $("#image_preview_modal").html @view('images/new')(@) 
    $($(".carousel-inner").children()[0]).addClass("active")

  getInstagramPhotos: (e, data) =>
    instagram_data = $('#open_image_preview_modal').data()

    url = "https://api.instagram.com/v1/users/#{instagram_data.uid}/media/recent"
    $.ajax({
              type: "GET",
              dataType: "jsonp",
              url: url,
              data: { access_token: "#{instagram_data.token}", count: 30 },
              success: (response) =>
                @renderImages(e, response.data)
          })

class App.ImagesIndex extends Spine.Controller
  constructor: ->
    super
    Photo.fetch()
    Photo.bind 'refresh', @render
    Photo.bind 'create',  @renderOne

  render: =>
    @images = Photo.all()
    for image in @images
      @addImage(image)

  renderOne: (data) =>
    @addImage(data.image)

  addImage: (image) =>
    image_html = @view('images/image')(image)
    $('#image_thumbnails').append(image_html)
    $('.fancybox').fancybox()