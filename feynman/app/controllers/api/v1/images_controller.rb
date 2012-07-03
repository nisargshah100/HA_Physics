class Api::V1::ImagesController < ApiController
  before_filter :authenticate

  def create
    @image = current_user.images.build(image_url: params[:image_url],
                                       width:     params[:width], 
                                       height:    params[:height])
    if @image.valid?
      @image.save
    else
      render :json => false
    end
  end

  def index
    if params[:user_id]
      @images = Image.find_all_by_user_id(params[:user_id])
    else
      @images = current_user.images
    end
  end
end
