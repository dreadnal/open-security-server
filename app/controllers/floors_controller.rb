class FloorsController < ApplicationController
  before_action :authorize_device
  before_action :set_floor, only: [:show]
  
  # GET /floors
  def index
    @floors = Floor.all
    json_response(@floors.to_json(include: :areas))
  end
  
  # GET /floors/:id
  def show
    json_response(@floor)
  end

  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device && @device.verified
    json_response('Authorization failed', :forbidden)
    return false
  end
  
  def set_floor
    @floor = Floor.find(params[:id])
  end
end