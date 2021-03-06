class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  data_table = GoogleVisualr::DataTable.new
 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) << :name
 end

end
