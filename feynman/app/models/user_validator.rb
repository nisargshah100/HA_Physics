class UserValidator
  attr_accessor :errors, :params

  def initialize(params)
    @errors = []
    @params = params
  end

  def validate_user_params
    validate_display_name if params.has_key? :display_name
    validate_email if params.has_key? :email
  end

  def validate_display_name
    if User.where(display_name: params[:display_name]).count > 0
      errors << "Display name already taken"
    end
  end

  def validate_email
    if User.where(email: params[:email]).count > 0
      errors << "E-mail address already registered"
    end
  end
end