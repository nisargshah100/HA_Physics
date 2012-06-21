class Api::V1::CategoriesController < ApiController
  def index
    if categories = Category.all
      render :json => categories, status: :ok
    else
      render status: :not_found
    end
  end
end
