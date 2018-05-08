class DevicesController < ApplicationController
  before_action :set_device, only: [:verify]
  
  # POST /devices/:id/verify
  def verify
    api_key = @device.verify(params[:one_time_password])
    json_response('Verification failed', :forbidden) if api_key.nil?
    json_response( { api_key: api_key, device_name: @device.name } ) unless api_key.nil?
  end

  #GET /devices/check
  def check
    @device = Device.find_by(api_key: request.headers['Authorization'])
    if @device && @device.verified
      json_response('Authorization successful')
      return
    end
    json_response('Authorization failed', :forbidden)
    return false
  end
  
  private
  
  def set_device
    @device = Device.find(params[:id])
  end
end