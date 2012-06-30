class Api::V1::ImagesController < ApiController
  before_filter :authenticate

  def create
    current_user.images.create(image_url: params[:image_url], width: params[:width], height: params[:height])
    render :json => true
  end

  def index
    @images = Image.find_by_user_id(params[:user_id])
    render :json => @images
  end
end
