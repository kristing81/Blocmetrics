class TrackedDomainsController < ApplicationController

  def index
    @tracked_domain = TrackedDomain.recent
  end

  def show
    @tracked_domain = TrackedDomain.find(params[:id])
  end

  def new
    @tracked_domain = TrackedDomain.new
  end

  def create
    @tracked_domain = TrackedDomain.new(td_params)
    if @tracked_domain.save
      flash[:notice] = "Tracked Domain created uccessfully."
      redirect_to(:action => 'index')
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
      redirect_to(:action => 'index')
    else
      render :edit
    end   
  end

  def delete
    @tracked_domain = TrackedDomain.find(params[:id])
  end

  def destroy
    @tracked_domain = TrackedDomain.find(params[:id])
    flash[:notice] = "Tracked Domain #{tracked_domain.name} deleted successfully."
    redirect_to(:action => 'index')
  end

  private

  def td_params
    params.require(:tracked_domain).permit(:user_id, :name, :description, :url, :verification_code, :verified) 
  end
end
