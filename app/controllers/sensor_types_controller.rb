class SensorTypesController < ApplicationController
  before_action :authorize_device
  before_action :set_sensor_type, only: [:show]
  
  # GET /sensor_types
  def index
    @sensor_types = SensorType.all
    json_response(@sensor_types)
  end
  
  # GET /sensor_types/:id
  def show
    json_response(@sensor_type)
  end

  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device
    json_response('Authorization failed', :forbidden)
    return false
  end
  
  def set_sensor_type
    @sensor_type = SensorType.find(params[:id])
  end
end