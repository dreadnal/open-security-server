class SensorsController < ApplicationController
  before_action :authorize_device, except: [:create]
  before_action :set_area, only: [:index, :show]
  before_action :set_floor, only: [:index, :show]
  before_action :set_sensor_type, only: [:index, :show]
  before_action :set_sensor, only: [:show]
  
  # GET /floors/:floor_id/sensors
  # GET /areas/:area_id/sensors
  # GET /sensor_types/:sensor_type_id/sensors
  # GET /sensors
  def index
    @sensors = Sensor.joins(:area).where({ areas: { floor_id: @floor.id } }) if @floor
    @sensors = @area.sensors if @area
    @sensors = @sensor_type.sensors if @sensor_type
    @sensors = Sensor.all unless @floor || @area || @sensor_type
    json_response(@sensors)
  end

  # GET /floors/:floor_id/sensors/:id
  # GET /areas/:area_id/sensors/:id
  # GET /sensor_types/:sensor_type_id/sensors/:id
  # GET /sensors/:id
  def show
    json_response(@sensor)
  end

  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device
    json_response('Authorization failed', :forbidden)
    return false
  end

  def set_area
    @area = Area.find(params[:area_id]) if params[:area_id]
  end

  def set_floor
    @floor = Floor.find(params[:floor_id]) if params[:floor_id]
  end

  def set_sensor_type
    @sensor_type = SensorType.find(params[:sensor_type_id]) if params[:sensor_type_id]
  end

  def set_sensor
    @sensor = Sensor.joins(:area).where({ areas: { floor_id: @floor.id } }).find_by!(id: params[:id]) if @floor
    @sensor = @area.sensors.find_by!(id: params[:id]) if @area
    @sensor = @sensor_type.sensors.find_by!(id: params[:id]) if @sensor_type
    @sensor = Sensor.find(params[:id]) unless @floor || @area || @sensor_type
  end
end