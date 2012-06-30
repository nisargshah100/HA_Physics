class App.Deal extends Spine.Model
  @configure "Deal", "original_id", "date_added", "end_date", "price_cents", 
    "value_cents", "title", "subtitle", "affiliate_url", "original_url", 
    "image_url", "source", "division_name", "original_category", "category", 
    "sold_out", "created_at", "updated_at", "original_subcategory", "latitude", 
    "longitude", "city", "state", "country", "last_purchase_count"

  @extend Spine.Model.Ajax

  @url: => 
    @token = $('.user_meta').data('token')

    url = "/api/v1/deals.json?token=#{@token}"      

window.Deal = App.Deal

