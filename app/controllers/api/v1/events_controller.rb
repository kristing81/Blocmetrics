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
    render nothing: true, status: :ok
  end

  private

  def event_params
    params.require(:event).permit(:tracked_domain_id, :event_type, :url, :ip_address, :created_at, :updated_at) 
  end

  def restrict_access
  authenticate_or_request_with_http_token do |token, options|
    ApiKey.exists?(access_token: token)
  end
end
 