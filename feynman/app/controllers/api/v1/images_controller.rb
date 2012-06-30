class Api::V1::ImagesController < ApiController
  before_filter :authenticate

  def create
    current_user.images.create(image_url: params[:image_url], width: params[:width], height: params[:height])
    render :json => true
  end
end
