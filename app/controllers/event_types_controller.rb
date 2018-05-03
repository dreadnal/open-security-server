class EventTypesController < ApplicationController
  before_action :authorize_device
  before_action :set_event_type, only: [:show]
  
  # GET /event_types
  def index
    @event_types = EventType.all
    json_response(@event_types)
  end
  
  # GET /event_types/:id
  def show
    json_response(@event_type)
  end
  
  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device && @device.verified
    json_response('Authorization failed', :forbidden)
    return false
  end
  
  def set_event_type
    @event_type = EventType.find(params[:id])
  end
end