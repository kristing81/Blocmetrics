class Api::V1::BaseController < ApplicationController

  respond_to :json

  skip_before_filter :verify_authenticity_token

  before_filter :preflight_check

  # do not run those 2 if the request.method is :options
  #before_filter :authenticate_user_from_token!
  #before_filter :authenticate_user!
  skip_before_filter :authenticate_user_from_token!
  skip_before_filter :authenticate_user!

  after_filter :set_headers

  def authenticate_user_from_token!
    token = params[:auth_token]
    user = User.where(authentication_token: token).first

    if user
      sign_in(user, store: false)
    end
  end

  private

   def set_headers
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = "POST, GET, OPTIONS"
    headers['Access-Control-Allow-Headers'] = "Content-Type"
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
end

