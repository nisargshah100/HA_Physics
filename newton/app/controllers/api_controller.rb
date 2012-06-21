class ApiController < ApplicationController
  before_filter :authenticate

  private

  def authenticate
    true
  end
end
