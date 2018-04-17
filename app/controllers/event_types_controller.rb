class EventTypesController < ApplicationController
    before_action :set_event_type, only: [:show, :update, :destroy]
    
    # GET /event_types
    def index
      @event_types = EventType.all
      json_response(@event_types)
    end
  
    # POST /event_types
    def create
      @event_type = EventType.create!(event_type_params)
      json_response(@event_type, :created)
    end
    
    # GET /event_types/:id
    def show
      json_response(@event_type)
    end
  
    # PUT /event_types/:id
    def update
      @event_type.update(event_type_params)
      head :no_content
    end
  
    # DELETE /event_types/:id
    def destroy
      @event_type.destroy
      head :no_content
    end
  
    private
    
    def event_type_params
      params.permit(:name, :icon)
    end
    
    def set_event_type
      @event_type = EventType.find(params[:id])
    end
  end