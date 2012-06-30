class App.Event extends Spine.Model
  @configure 'Event', 'source', 'deal_id', 'user_id', 'date', 'description'
  @extend Spine.Model.Ajax
  # @token: $('user_info').data('token')
  # @url: '/api/v1/events.json?token=#{@token}'
  @url: => 
    @token = $('.user_meta').data('token')
    @user_id = $('.user_meta').data('id')

    url = "/api/v1/events.json?token=#{@token}"
    if @user_id? then "#{url}&user_id=#{@user_id}" else url
      

window.Event = App.Event