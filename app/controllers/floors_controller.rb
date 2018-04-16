class FloorsController < ApplicationController
  before_action :set_floor, only: [:show, :update, :destroy]
  
  # GET /floors
  def index
    @floors = Floor.all
    json_response(@floors)
  end

  # POST /floors
  def create
    @floor = Floor.create!(floor_params)
    json_response(@floor, :created)
  end
  
  # GET /floors/:id
  def show
    json_response(@floor)
  end

  # PUT /floors/:id
  def update
    @floor.update(floor_params)
    head :no_content
  end

  # DELETE /floors/:id
  def destroy
    @floor.destroy
    head :no_content
  end

  private
  
  def floor_params
    params.permit(:name, :position, :data)
  end
  
  def set_floor
    @floor = Floor.find(params[:id])
  end
end