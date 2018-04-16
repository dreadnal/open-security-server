class AreasController < ApplicationController
    before_action :set_floor
    before_action :set_area, only: [:show, :update, :destroy]
  
    # GET /floors/:floor_id/areas
    def index
      json_response(@floor.areas)
    end
  
    # GET /floors/:floor_id/areas/:id
    def show
      json_response(@area)
    end
  
    # POST /floors/:floor_id/areas
    def create
      @floor.areas.create!(area_params)
      json_response(@area, :created)
    end
  
    # PUT /floors/:floor_id/areas/:id
    def update
      @area.update(area_params)
      head :no_content
    end
  
    # DELETE /floors/:floor_id/areas/:id
    def destroy
      @area.destroy
      head :no_content
    end
  
    private
  
    def area_params
      params.permit(:name, :data)
    end
  
    def set_floor
      @floor = Floor.find(params[:floor_id])
    end
  
    def set_area
      @area = @floor.areas.find_by!(id: params[:id]) if @floor
    end
  end