require 'rails_helper'

RSpec.describe 'Event API', type: :request do
  let!(:floor) { create(:floor) }
  let!(:area) { create(:area, floor_id: floor.id) }
  let!(:sensor_type) { create(:sensor_type) }
  let!(:sensor) { create(:sensor, area_id: area.id, sensor_type_id: sensor_type.id) }
  let!(:event_type) { create(:event_type) }
  let!(:events) { create_list(:event, 10, sensor_id: sensor.id, event_type_id: event_type.id) }
  let(:floor_id) {floor.id}
  let(:area_id) {area.id}
  let(:sensor_type_id) {sensor_type.id}
  let(:sensor_id) { sensor.id }
  let(:event_type_id) { event_type.id }
  let(:event_id) { events.first.id }

  # Test suite for GET /floors/:floor_id/events
  describe 'GET /floors/:floor_id/events' do
    before { get "/floors/#{floor_id}/events" }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /floors/:floor_id/events/unread
  describe 'GET /floors/:floor_id/events/unread' do
    before { get "/floors/#{floor_id}/events/unread" }
    it 'returns unread events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /floors/:floor_id/events/read
  describe 'GET /floors/:floor_id/events/read' do
    before { get "/floors/#{floor_id}/events/read" }

    it 'returns read events' do
      expect(json).to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /floors/:floor_id/event_types/:event_type_id/events
  describe 'GET /floors/:floor_id/event_types/:event_type_id/events' do
    before { get "/floors/#{floor_id}/event_types/#{event_type_id}/events" }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /floors/:floor_id/event_types/:event_type_id/events/unread
  describe 'GET /floors/:floor_id/event_types/:event_type_id/events/unread' do
    before { get "/floors/#{floor_id}/event_types/#{event_type_id}/events/unread" }

    it 'returns unread events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /floors/:floor_id/event_types/:event_type_id/events/read
  describe 'GET /floors/:floor_id/event_types/:event_type_id/events/read' do
    before { get "/floors/#{floor_id}/event_types/#{event_type_id}/events/read" }

    it 'returns read events' do
      expect(json).to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/events
  describe 'GET /areas/:area_id/events' do
    before { get "/areas/#{area_id}/events" }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/events/unread
  describe 'GET /areas/:area_id/events/unread' do
    before { get "/areas/#{area_id}/events/unread" }

    it 'returns unread events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/events/read
  describe 'GET /areas/:area_id/events/read' do
    before { get "/areas/#{area_id}/events/read" }

    it 'returns read events' do
      expect(json).to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/event_types/:event_type_id/events
  describe 'GET /areas/:area_id/event_types/:event_type_id/events' do
    before { get "/areas/#{area_id}/event_types/#{event_type_id}/events" }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/event_types/:event_type_id/events/unread
  describe 'GET /areas/:area_id/event_types/:event_type_id/events/unread' do
    before { get "/areas/#{area_id}/event_types/#{event_type_id}/events/unread" }

    it 'returns unread events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/event_types/:event_type_id/events/read
  describe 'GET /areas/:area_id/event_types/:event_type_id/events/read' do
    before { get "/areas/#{area_id}/event_types/#{event_type_id}/events/read" }

    it 'returns read events' do
      expect(json).to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sensors/:sensor_id/events
  describe 'GET /sensors/:sensor_id/events' do
    before { get "/sensors/#{sensor_id}/events" }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sensors/:sensor_id/events/unread
  describe 'GET /sensors/:sensor_id/events/unread' do
    before { get "/sensors/#{sensor_id}/events/unread" }

    it 'returns unread events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sensors/:sensor_id/events/read
  describe 'GET /sensors/:sensor_id/events/read' do
    before { get "/sensors/#{sensor_id}/events/read" }

    it 'returns read events' do
      expect(json).to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /event_types/:event_type_id/events
  describe 'GET /event_types/:event_type_id/events' do
    before { get "/event_types/#{event_type_id}/events" }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /event_types/:event_type_id/events/unread
  describe 'GET /event_types/:event_type_id/events/unread' do
    before { get "/event_types/#{event_type_id}/events/unread" }

    it 'returns unread events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /event_types/:event_type_id/events/read
  describe 'GET /event_types/:event_type_id/events/read' do
    before { get "/event_types/#{event_type_id}/events/read" }

    it 'returns read events' do
      expect(json).to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /events
  describe 'GET /events' do
    before { get '/events' }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /events/unread
  describe 'GET /events/unread' do
    before { get '/events/unread' }

    it 'returns unread events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /events/read
  describe 'GET /events/read' do
    before { get '/events/read' }

    it 'returns read events' do
      expect(json).to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/events/:id
  describe 'GET /areas/:area_id/events/:id' do
    before { get "/areas/#{area_id}/events/#{event_id}" }

    context 'when the record exists' do
      it 'returns the events' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
 
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/events/:id
  describe 'GET /floors/:floor_id/events/:id' do
    before { get "/floors/#{floor_id}/events/#{event_id}" }

    context 'when the record exists' do
      it 'returns the events' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
 
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  # Test suite for GET /sensors/:sensor_id/events/:id
  describe 'GET /sensors/:sensor_id/events/:id' do
    before { get "/sensors/#{sensor_id}/events/#{event_id}" }

    context 'when the record exists' do
      it 'returns the events' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
 
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  # Test suite for GET /event_types/:event_type_id/events/:id
  describe 'GET /event_types/:event_type_id/events/:id' do
    before { get "/event_types/#{event_type_id}/events/#{event_id}" }

    context 'when the record exists' do
      it 'returns the events' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
 
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  # Test suite for POST /sensors/:sensor_id/events
  describe 'POST /sensors/:sensor_id/events' do
    let(:valid_attributes) { { event_type_id: event_type_id, state: 'unread' } }

    context 'when the request is valid' do
      before { post "/sensors/#{sensor_id}/events", params: valid_attributes }

      it 'creates a events' do
        expect(json['event_type_id']).to eq(event_type_id)
        expect(json['state']).to eq('unread')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/sensors/#{sensor_id}/events", params: { event_type_id: event_type_id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: State can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post "/sensors/#{sensor_id}/events", params: { state: 'unread' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Event type must exist/)
      end
    end
  end

  # Test suite for PUT /sensors/:sensor_id/events/:id
  describe 'PUT /sensors/:sensor_id/events/:id' do
    let(:valid_attributes) { { event_type_id: event_type_id, state: 'read' } }

    context 'when the record exists' do
      before { put "/sensors/#{sensor_id}/events/#{event_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /sensors/:sensor_id/events/:id
  describe 'DELETE /sensors/:sensor_id/events/:id' do
    before { delete "/sensors/#{sensor_id}/events/#{event_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end