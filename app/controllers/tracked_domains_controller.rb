class TrackedDomainsController < ApplicationController 

  before_filter :authenticate_user!
  
  def index
    @tracked_domains = TrackedDomain.recent
  end

  def show
    @tracked_domain = TrackedDomain.find(params[:id])
  end

  def new
    @tracked_domain = TrackedDomain.new
  end

  def create
    @tracked_domain = TrackedDomain.new(td_params)
    @tracked_domain.user = current_user
    if @tracked_domain.save
      flash[:notice] = "Tracked Domain created uccessfully."
      redirect_to @tracked_domain
    else
      render :new  
    end  
  end

  def edit
    @tracked_domain = TrackedDomain.find(params[:id])
  end

  def update
    @tracked_domain = TrackedDomain.find(params[:id])
    if @tracked_domain.update_attributes(td_params)
      flash[:notice] = "Tracked Domain #{@tracked_domain.name} updated successfully."
      redirect_to @tracked_domain
    else
      render :edit
    end   
  end

  def delete
    @tracked_domain = TrackedDomain.find(params[:id])
  end

  def destroy
    @tracked_domain = TrackedDomain.find(params[:id])
    if @tracked_domain.destroy
    flash[:notice] = "Tracked Domain deleted successfully."
    else
     flash[:error] = "There was an error deleting the tracked_domain."
    end
    redirect_to tracked_domains_path
  end

  private

  def td_params
    params.require(:tracked_domain).permit(:user_id, :name, :description, :url, :verification_code, :verified) 
  end
end
