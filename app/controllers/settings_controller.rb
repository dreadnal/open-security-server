class SettingsController < ApplicationController
    before_action :set_setting, only: [:show, :update, :destroy]
    
    # GET /settings
    def index
      @settings = Setting.all
      json_response(@settings)
    end
  
    # POST /settings
    def create
      @setting = Setting.create!(setting_params)
      json_response(@setting, :created)
    end
    
    # GET /settings/:id
    def show
      json_response(@setting)
    end
  
    # PUT /settings/:id
    def update
      @setting.update(setting_params)
      head :no_content
    end
  
    # DELETE /settings/:id
    def destroy
      @setting.destroy
      head :no_content
    end
  
    private
    
    def setting_params
      params.permit(:name, :value)
    end
    
    def set_setting
      @setting = Setting.find(params[:id])
    end
  end