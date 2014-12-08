class Api::V1::EventsController < Api::V1::BaseController

  def create
    @tracked_domain = current_user.tracked_domain_from_url(request.referer)
    if @tracked_domain.blank?
      render nothing: true, status: :forbidden
    else
      @event = @tracked_domain.events.build(params[:event_params])
      if @event.save
        respond_with @event, location: api_v1_event_path(@event)
      else
        render json: {:error => "Invalid event"}, status: :unprocessable_entity 
      end
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

end
 