class CamerasController < ApplicationController
  before_action :authorize_device
  before_action :set_area
  before_action :set_floor
  before_action :set_camera, only: [:show]
    
  # GET /floors/:floor_id/cameras
  # GET /areas/:area_id/cameras
  # GET /cameras
  def index
    @cameras = Camera.joins(:area).where({ areas: { floor_id: @floor.id } }) if @floor
    @cameras = @area.cameras if @area
    @cameras = Camera.all unless @floor || @area
    json_response(@cameras)
  end
    
  # GET /floors/:floor_id/cameras/:id
  # GET /areas/:area_id/cameras/:id
  # GET /cameras/:id
  def show
    json_response(@camera)
  end

  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device && @device.verified
    json_response('Authorization failed', :forbidden)
    return false
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