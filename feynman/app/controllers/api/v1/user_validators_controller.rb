class Api::V1::UserValidatorsController < ApiController
  def create
    validator = UserValidator.new(params)
    validator.validate_user_params
    render :json => validator.errors
  end
end
