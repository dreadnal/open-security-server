class DevicesController < ApplicationController
  before_action :set_device
  
  # POST /devices/:id/verify
  def verify
    api_key = @device.verify(params[:one_time_password])
    json_response('Verification failed', :forbidden) if api_key.nil?
    json_response( { api_key: api_key } ) unless api_key.nil?
  end
  
  private
  
  def set_device
    @device = Device.find(params[:id])
  end
end