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

  def chart
  data_table = GoogleVisualr::DataTable.new
  data_table.new_column('integer', 'Tracked Domain ID' )
  data_table.new_column('string', 'Event Type')
  data_table.new_column('string', 'URL')
  data_table.new_column('string', 'IP address')

  # Add Rows and Values
  data_table.add_rows([
    ['2004', 1000, 400],
    ['2005', 1170, 460],
    ['2006', 660, 1120],
    ['2007', 1030, 540]
  ])

  end
  private

  def event_params
    params.require(:event).permit(:tracked_domain_id, :event_type, :url, :ip_address, :created_at, :updated_at) 
  end
end
 