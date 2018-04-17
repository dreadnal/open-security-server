class SensorTypesController < ApplicationController
    before_action :set_sensor_type, only: [:show, :update, :destroy]
    
    # GET /sensor_types
    def index
      @sensor_types = SensorType.all
      json_response(@sensor_types)
    end
  
    # POST /sensor_types
    def create
      @sensor_type = SensorType.create!(sensor_type_params)
      json_response(@sensor_type, :created)
    end
    
    # GET /sensor_types/:id
    def show
      json_response(@sensor_type)
    end
  
    # PUT /sensor_types/:id
    def update
      @sensor_type.update(sensor_type_params)
      head :no_content
    end
  
    # DELETE /sensor_types/:id
    def destroy
      @sensor_type.destroy
      head :no_content
    end
  
    private
    
    def sensor_type_params
      params.permit(:name, :icon, :model, :note)
    end
    
    def set_sensor_type
      @sensor_type = SensorType.find(params[:id])
    end
  end