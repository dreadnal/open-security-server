class CamerasController < ApplicationController
    before_action :set_camera, only: [:show, :update, :destroy]
    
    # GET /cameras
    def index
      @cameras = Camera.all
      json_response(@cameras)
    end
  
    # POST /cameras
    def create
      @camera = Camera.create!(camera_params)
      json_response(@camera, :created)
    end
    
    # GET /cameras/:id
    def show
      json_response(@camera)
    end
  
    # PUT /cameras/:id
    def update
      @camera.update(camera_params)
      head :no_content
    end
  
    # DELETE /cameras/:id
    def destroy
      @camera.destroy
      head :no_content
    end
  
    private
    
    def camera_params
      params.permit(:name, :address, :note, :data)
    end
    
    def set_camera
      @camera = Camera.find(params[:id])
    end
  end