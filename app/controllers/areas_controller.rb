class AreasController < ApplicationController
    before_action :set_floor, only: [:index, :show]
    before_action :require_set_floor, except: [:index, :show]
    before_action :set_area, only: [:show, :update, :destroy]
  
    # GET /floors/:floor_id/areas
    # GET /areas
    def index
      @areas = @floor.areas if @floor
      @areas = Area.all unless @floor
      json_response(@areas)
    end
  
    # GET /floors/:floor_id/areas/:id
    # GET /areas/:id
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
  
    def require_set_floor
      @floor = Floor.find(params[:floor_id])
    end

    def set_floor
      @floor = Floor.find(params[:floor_id]) if params[:floor_id]
    end
  
    def set_area
      @area = @floor.areas.find_by!(id: params[:id]) if @floor
      @area = Area.find_by!(id: params[:id]) unless @floor
    end
  end