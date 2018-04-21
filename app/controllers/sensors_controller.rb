class SensorsController < ApplicationController
    before_action :set_area, only: [:index, :show]
    before_action :require_set_area, except: [:index, :show]
    before_action :set_floor, only: [:index, :show]
    before_action :set_sensor_type, only: [:index, :show]
    before_action :set_sensor, only: [:show, :update, :destroy]
      
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
    
    # POST /areas/:area_id/sensors
    def create
      @sensor = @area.sensors.create!(sensor_params)
      json_response(@sensor, :created)
    end
      
    # GET /floors/:floor_id/sensors/:id
    # GET /areas/:area_id/sensors/:id
    # GET /sensor_types/:sensor_type_id/sensors/:id
    # GET /sensors/:id
    def show
      json_response(@sensor)
    end
    
    # PUT /areas/:area_id/sensors/:id
    def update
      @sensor.update(sensor_params)
      head :no_content
    end
  
    # DELETE /areas/:area_id/sensors/:id
    def destroy
      @sensor.destroy
      head :no_content
    end
  
    private
    
    def sensor_params
      params.permit(:name, :address, :note, :data, :api_key, :sensor_type_id)
    end
    
    def require_set_area
      @area = Area.find(params[:area_id])
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