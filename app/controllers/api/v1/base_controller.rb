class Api::V1::BaseController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token

  before_filter :preflight_check
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  after_filter :set_headers


  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Headers'] = 'Content-Type'
    headers['Access-Control-Max-Age'] = '86400'
  end

  def preflight_check
    if request.method == :options
      headers["Access-Control-Allow-Origin"] = "*"
      headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE OPTIONS}.join(",")
      headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
      render nothing: true and return
    end
  end

  def authenticate_user_from_token!
    user_auth_token = params[:auth_token]

    user = User.where(authentication_token: user_auth_token).first
    if user
      sign_in(user, store: false)
    end
  end
end
