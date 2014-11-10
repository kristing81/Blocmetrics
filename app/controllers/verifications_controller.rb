class VerificationsController < ApplicationController 
  
  before_filter :authenticate_user!

  def update
    @tracked_domain = current_user.tracked_domains.find(params[:id])
    if @tracked_domain.check_verification
      flash[:notice] = "Successfully verified domain"
    else
      flash[:notice] = "Failed to verify domain"
    end
    redirect_to @tracked_domain
  end
end

