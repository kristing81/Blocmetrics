class Api::V1::EventsController < Api::V1::BaseController

  attr_accessor :event, :event_type

  def create
    @tracked_domain = TrackedDomain.find(params[:verification_code])
    @event = @tracked_domain.event.new(event_params).to_json
    if @event.save
    render nothing: true, status:200
    else 
      render :new
    end
  end

  
  def index
    render nothing: true, status: :ok
    # @events = Event.all
    # @event_type = "Page View"
    # render :json => @events.to_json
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
end
 