class CamerasController < ApplicationController
  before_action :set_area, only: [:index, :show]
  before_action :require_set_area, except: [:index, :show]
  before_action :set_floor, only: [:index, :show]
  before_action :set_camera, only: [:show, :update, :destroy]
    
  # GET /floors/:floor_id/cameras
  # GET /areas/:area_id/cameras
  # GET /cameras
  def index
    @cameras = Camera.joins(:area).where({ areas: { floor_id: @floor.id } }) if @floor
    @cameras = @area.cameras if @area
    @cameras = Camera.all unless @floor || @area
    json_response(@cameras)
  end
  
  # POST /areas/:area_id/cameras
  def create
    @camera = @area.cameras.create!(camera_params)
    json_response(@camera, :created)
  end
    
  # GET /floors/:floor_id/cameras/:id
  # GET /areas/:area_id/cameras/:id
  # GET /cameras/:id
  def show
    json_response(@camera)
  end
  
  # PUT /areas/:area_id/cameras/:id
  def update
    @camera.update(camera_params)
    head :no_content
  end

  # DELETE /areas/:area_id/cameras/:id
  def destroy
    @camera.destroy
    head :no_content
  end

  private
  
  def camera_params
    params.permit(:name, :address, :note, :data)
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
  
  def set_camera
    @camera = Camera.joins(:area).where({ areas: { floor_id: @floor.id } }).find_by!(id: params[:id]) if @floor
    @camera = @area.cameras.find_by!(id: params[:id]) if @area
    @camera = Camera.find(params[:id]) unless @floor || @area
  end
end