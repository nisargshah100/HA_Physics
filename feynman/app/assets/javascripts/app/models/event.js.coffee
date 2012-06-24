class App.Event extends Spine.Model
  @configure 'Event', 'source', 'deal_id', 'user_id', 'date', 'description_short', 'description_long'
  @extend Spine.Model.Ajax
  # @token: $('user_info').data('token')
  # @url: '/api/v1/events.json?token=#{@token}'
  @url: '/api/v1/events.json'

window.Event = App.Event