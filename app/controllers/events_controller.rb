class EventsController < ApplicationController
  before_action :authorize_device, except: [:create]
  before_action :require_set_sensor, only: [:create]
  before_action :authorize_sensor, only: [:create]
  before_action :set_sensor, only: [:index, :show, :unread, :read]
  before_action :set_floor, only: [:index, :show, :unread, :read]
  before_action :set_area, only: [:index, :show, :unread, :read]
  before_action :set_event_type, only: [:index, :show, :unread, :read]
  before_action :set_event, only: [:show]

  # GET /floors/:floor_id/events
  # GET /floors/:floor_id/event_types/:event_type_id/events
  # GET /areas/:area_id/events
  # GET /areas/:area_id/event_types/:event_type_id/events
  # GET /sensors/:sensor_id/events
  # GET /sensors/:sensor_id/event_types/:event_type_id/events
  # GET /event_types/:event_type_id/events
  # GET /events
  def index
    @events = Event.all
    @events = @events.where( sensor_id: @sensor.id ) if @sensor
    @events = @events.joins(:sensor).where({ sensors: { area_id: @area.id }  }) if @area
    @events = @events.joins(sensor: :area).where({ areas: { floor_id: @floor.id } }) if @floor
    @events = @events.where( event_type_id: @event_type.id) if @event_type
    json_response(@events)
  end

  # GET /floors/:floor_id/events/unread
  # GET /floors/:floor_id/event_types/:event_type_id/events/unread
  # GET /areas/:area_id/events/unread
  # GET /areas/:area_id/event_types/:event_type_id/events/unread
  # GET /sensors/:sensor_id/events/unread
  # GET /sensors/:sensor_id/event_types/:event_type_id/events/unread
  # GET /event_types/:event_type_id/events/unread
  # GET /events/unread
  def unread
    @events = Event.all
    @events = @events.where( sensor_id: @sensor.id ) if @sensor
    @events = @events.joins(:sensor).where({ sensors: { area_id: @area.id }  }) if @area
    @events = @events.joins(sensor: :area).where({ areas: { floor_id: @floor.id } }) if @floor
    @events = @events.where( event_type_id: @event_type.id) if @event_type
    @events = @events.where( state: 'unread' )
    json_response(@events)
  end

  # GET /floors/:floor_id/events/read
  # GET /floors/:floor_id/event_types/:event_type_id/events/read
  # GET /areas/:area_id/events/read
  # GET /areas/:area_id/event_types/:event_type_id/events/read
  # GET /sensors/:sensor_id/events/read
  # GET /sensors/:sensor_id/event_types/:event_type_id/events/read
  # GET /event_types/:event_type_id/events/read
  # GET /events/read
  def read
    @events = Event.all
    @events = @events.where( sensor_id: @sensor.id ) if @sensor
    @events = @events.joins(:sensor).where({ sensors: { area_id: @area.id }  }) if @area
    @events = @events.joins(sensor: :area).where({ areas: { floor_id: @floor.id } }) if @floor
    @events = @events.where( event_type_id: @event_type.id) if @event_type
    @events = @events.where( state: 'read' )
    json_response(@events)
  end

  # POST /sensors/:sensor_id/events
  def create
    @event = @sensor.events.create!(event_params)
    json_response(@event, :created)
  end
  
  # GET /floors/:floor_id/events/:id
  # GET /areas/:area_id/events/:id
  # GET /sensors/:sensor_id/events/:id
  # GET /event_types/:event_type_id/events/:id
  # GET /events/:id
  def show
    json_response(@event)
  end

  private

  def authorize_device
    @device = Device.find_by(api_key: request.headers['Authorization'])
    return true if @device && @device.verified
    json_response('Authorization failed', :forbidden)
    return false
  end

  def authorize_sensor
    @sensor_sender = Sensor.find_by(api_key: request.headers['Authorization'])
    return true if @sensor_sender && @sensor_sender.id == @sensor.id
    json_response('Authorization failed', :forbidden)
    return false
  end

  def event_params
    params.permit(:event_type_id, :state)
  end

  def set_area
    @area = Area.find(params[:area_id]) if params[:area_id]
  end

  def set_floor
    @floor = Floor.find(params[:floor_id]) if params[:floor_id]
  end

  def set_sensor
    @sensor = Sensor.find(params[:sensor_id]) if params[:sensor_id]
  end

  def require_set_sensor
    @sensor = Sensor.find(params[:sensor_id])
  end

  def set_event_type
    @event_type = EventType.find(params[:event_type_id]) if params[:event_type_id]
  end

  def set_event
    @events = Event.all
    @events = @events.where( sensor_id: @sensor.id ) if @sensor
    @events = @events.joins(:sensor).where({ sensors: { area_id: @area.id }  }) if @area
    @events = @events.joins(sensor: :area).where({ areas: { floor_id: @floor.id } }) if @floor
    @events = @events.where( event_type_id: @event_type.id) if @event_type
    
    @event = @events.find_by!(id: params[:id])
  end
end