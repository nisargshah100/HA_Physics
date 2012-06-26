class App.Event extends Spine.Model
  @configure 'Event', 'source', 'deal_id', 'user_id', 'date', 'description_short', 'description_long'
  @extend Spine.Model.Ajax
  # @token: $('user_info').data('token')
  # @url: '/api/v1/events.json?token=#{@token}'
  @url: => 
    @user_id = $('.user_meta').data('id')
    url = "/api/v1/events.json"
    if @user_id?
      url = "#{url}?user_id=#{@user_id}"
    url
      
      

window.Event = App.Event