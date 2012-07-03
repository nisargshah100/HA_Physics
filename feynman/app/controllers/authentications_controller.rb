class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
  end
end
