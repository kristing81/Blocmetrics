class EventsController < ApplicationController
  
  def index
    @event = Event.recent
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event created successfully."
      redirect_to(:action => 'index')
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "Event updated successfully."
      redirect_to(:action => 'index')
    else
      render :edit
    end
  end

  def delete
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    flash[:notice] = "Event deleted successfully."
    redirect_to(:action => 'index')
  end

  private

  def event_params
    params.require(:event).permit(:event_type, :url, :ip_address, :created_at, :updated_at) 
  end
end