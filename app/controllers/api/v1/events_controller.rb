class Api::V1::EventsController < Api::V1::BaseController

  attr_accessor :event, :event_type
  before_filter :preflight_check
  after_filter :set_headers
  skip_before_filter :authenticate_user_from_token!
  skip_before_filter :authenticate_user!

  def create
    # {auth_token: "", event_type: ""}
    # Rails request object
    @tracked_domain = current_user.tracked_domains.where(params[user: :auth_token]).first.to_json
    @event.ip_address = request.env["HTTP_REFERER"]
    @event = Event.new
    if @event.save
      respond_with @event, location: api_v1_event_path(@event)
    else
      render json: {:error => "Invalid event"}, status: :unprocessable_entity 
    end
  end

  def index
    render nothing: true, status: :ok
    @events = Event.all
  end

  # def chart
  # data_table = GoogleVisualr::DataTable.new
  # data_table.new_column('string', 'Event Type')
  # data_table.new_column('string', 'URL')
  # data_table.new_column('string', 'Date')
  # #I want to show page views per day
  # data_table.add_rows(#)
  #   #data_table.set_cell(0, 0, '2004')
    # use JSON to parse(events) ???

  #   opts   = { :width => 400, :height => 240, :title => 'Daily Page Views', :hAxis => { :title => 'Date' } }
  #   @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)

  # end
  
  private

  def event_params
    params.require(:event).permit(:tracked_domain_id, :event_type, :url, :ip_address, :created_at, :updated_at) 
  end

   def set_headers
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Allow-Methods'] = "POST, GET, OPTIONS"
    headers['Access-Control-Allow-Headers'] = "Content-Type"
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
end
 