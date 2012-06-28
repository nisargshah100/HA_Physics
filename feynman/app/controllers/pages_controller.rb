class PagesController < ApplicationController
  def index
    @user_detail = UserDetail.new
  end
end
