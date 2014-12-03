class Api::V1::BaseController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

 

  # do not run those 2 if the request.method is :options
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  #skip_before_filter :authenticate_user_from_token!
  #skip_before_filter :authenticate_user!

  

  def authenticate_user_from_token!
    token = params[:auth_token]
    user = User.where(authentication_token: token).first

    if user
      sign_in(user, store: false)
    end
  end

end

