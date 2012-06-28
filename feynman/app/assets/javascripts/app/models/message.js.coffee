class App.Message extends Spine.Model
  @configure 'Message', 'sender', 'body', 'created_at', 'status'
  @extend Spine.Model.Ajax

  @url: => 
    @token = $('.user_meta').data('token')
    url = "/api/v1/messages.json?token=#{@token}"

window.Message = App.Message