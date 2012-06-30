class App.Image extends Spine.Model
  @configure 'Image', 'user', 'image_url', 'width', 'height'
  @extend Spine.Model.Ajax

  @url: => 
    @token = $('.user_meta').data('token')
    url = "/api/v1/images.json?token=#{@token}"

window.Message = App.Message