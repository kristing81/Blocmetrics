class EventsController < ApplicationController
  respond_to :html, :js

  attr_accessor :tracked_domain_id
  
  before_action :find_tracked_domain

  before_filter :set_headers
  
  def index
    @events = @tracked_domain.events.recent
  end

  def show
    @event = @tracked_domain.events.find(params[:id])
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
    @event = @tracked_domain.events.find(params[:id])
  end

  def update
    @event = @tracked_domain.events.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "Event updated successfully."
      redirect_to(:action => 'index')
    else
      render :edit
    end
  end

  def delete
    @event = @tracked_domain.events.find(params[:id])
  end

  def destroy
    @event = @tracked_domain.events.find(params[:id]).destroy
    flash[:notice] = "Event deleted successfully."
    redirect_to(:action => 'index')
  end

  private

  def event_params
    params.require(:event).permit(:tracked_domain_id, :event_type, :url, :ip_address, :created_at, :updated_at) 
  end

  def find_tracked_domain
    if params[:tracked_domain_id]
      @tracked_domain = current_user.tracked_domains.find(params[:tracked_domain_id])  
    end
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = '1728000'
  end
end