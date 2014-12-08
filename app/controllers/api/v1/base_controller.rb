class Api::V1::BaseController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token
  before_filter :preflight_check
  after_filter :set_headers

  # do not run those 2 if the request.method is :options
  before_filter :authenticate_user_from_token!

  def authenticate_user_from_token!
    token = params[:auth_token]
    user = User.where(authentication_token: token).first
    if user
      sign_in(user, store: false)
    else
      render nothing: true, status: :unauthorized
    end
  end


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

