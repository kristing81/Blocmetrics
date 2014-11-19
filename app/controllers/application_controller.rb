class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_filter :authenticate_user_from_token!

  before_filter :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  data_table = GoogleVisualr::DataTable.new
 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) << :name
 end

   def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    end
  end
end
