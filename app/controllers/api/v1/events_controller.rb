class Api::V1::EventsController < Api::V1::BaseController

  def create
    @tracked_domain = TrackedDomain.find(params[:verification_code])
    # find a domain via the submitted verification token
    @event = @tracked_domain.event.new(event_params).to_json
    if @event.save
    # record event
    render nothing: true, status:200
    else 
      render :new
    end
  end

  
  def index
    @events = Event.all
  end

  private

  def event_params
    params.require(:event).permit(:tracked_domain_id, :event_type, :url, :ip_address, :created_at, :updated_at) 
  end
end
 