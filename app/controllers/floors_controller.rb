class FloorsController < ApplicationController
  before_action :authorize_device
  before_action :set_floor, only: [:show]
  
  # GET /floors
  def index
    @floors = Floor.all
    json_response(@floors)
  end
  
  # GET /floors/:id
  def show
    json_response(@floor)
  end

  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device
    json_response('Authorization failed', :forbidden)
    return false
  end
  
  def set_floor
    @floor = Floor.find(params[:id])
  end
end