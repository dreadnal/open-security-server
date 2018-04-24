class AreasController < ApplicationController
  before_action :authorize_device
  before_action :set_floor
  before_action :set_area, only: [:show]

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

  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device
    json_response('Authorization failed', :forbidden)
    return false
  end

  def set_floor
    @floor = Floor.find(params[:floor_id]) if params[:floor_id]
  end

  def set_area
    @area = @floor.areas.find_by!(id: params[:id]) if @floor
    @area = Area.find_by!(id: params[:id]) unless @floor
  end
end