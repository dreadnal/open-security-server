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
  let!(:device) { create(:device) }
  let(:api_key) { device.verify(device.one_time_password) }
  let(:header) { { 'Authorization' => api_key } }
  let(:header_sensor) { { 'Authorization' => sensor.api_key } }
  let(:invalid_header) { { 'Authorization' => 'foo bar' } }

  # Test suite for GET /events
  describe 'GET /events' do
    before { get '/events', headers: header }

    context 'when api key is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns events' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end
  
  # Test suite for GET /events/unread
  describe 'GET /events/unread' do
    before { get '/events/unread', headers: header }

    context 'when api key is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns events' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /events/read
  describe 'GET /events/read' do
    before { get '/events/read', headers: header }

    context 'when api key is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns read events' do
        expect(json).to be_empty
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/events
  describe 'GET /floors/:floor_id/events' do
    before { get "/floors/#{floor_id}/events", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when floor does not exist' do
        let(:floor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Floor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/events/unread
  describe 'GET /floors/:floor_id/events/unread' do
    before { get "/floors/#{floor_id}/events/unread", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns unread events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when floor does not exist' do
        let(:floor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Floor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/events/read
  describe 'GET /floors/:floor_id/events/read' do
    before { get "/floors/#{floor_id}/events/read", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns read events' do
          expect(json).to be_empty
        end
      end

      context 'when floor does not exist' do
        let(:floor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Floor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/event_types/:event_type_id/events
  describe 'GET /floors/:floor_id/event_types/:event_type_id/events' do
    before { get "/floors/#{floor_id}/event_types/#{event_type_id}/events", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        context 'when event type exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns events' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
          end
        end
  
        context 'when event type does not exist' do
          let(:event_type_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find EventType/)
          end
        end
      end

      context 'when floor does not exist' do
        let(:floor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Floor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/event_types/:event_type_id/events/unread
  describe 'GET /floors/:floor_id/event_types/:event_type_id/events/unread' do
    before { get "/floors/#{floor_id}/event_types/#{event_type_id}/events/unread", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        context 'when event type exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns unread events' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
          end
        end
  
        context 'when event type does not exist' do
          let(:event_type_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find EventType/)
          end
        end
      end

      context 'when floor does not exist' do
        let(:floor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Floor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/event_types/:event_type_id/events/read
  describe 'GET /floors/:floor_id/event_types/:event_type_id/events/read' do
    before { get "/floors/#{floor_id}/event_types/#{event_type_id}/events/read", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        context 'when event type exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns read events' do
            expect(json).to be_empty
          end
        end
  
        context 'when event type does not exist' do
          let(:event_type_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find EventType/)
          end
        end
      end

      context 'when floor does not exist' do
        let(:floor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Floor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /areas/:area_id/events
  describe 'GET /areas/:area_id/events' do
    before { get "/areas/#{area_id}/events", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when area does not exist' do
        let(:area_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Area/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /areas/:area_id/events/unread
  describe 'GET /areas/:area_id/events/unread' do
    before { get "/areas/#{area_id}/events/unread", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns unread events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when area does not exist' do
        let(:area_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Area/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /areas/:area_id/events/read
  describe 'GET /areas/:area_id/events/read' do
    before { get "/areas/#{area_id}/events/read", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns read events' do
          expect(json).to be_empty
        end
      end

      context 'when area does not exist' do
        let(:area_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Area/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /areas/:area_id/event_types/:event_type_id/events
  describe 'GET /areas/:area_id/event_types/:event_type_id/events' do
    before { get "/areas/#{area_id}/event_types/#{event_type_id}/events", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when area does not exist' do
        let(:area_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Area/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /areas/:area_id/event_types/:event_type_id/events/unread
  describe 'GET /areas/:area_id/event_types/:event_type_id/events/unread' do
    before { get "/areas/#{area_id}/event_types/#{event_type_id}/events/unread", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns unread events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when area does not exist' do
        let(:area_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Area/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /areas/:area_id/event_types/:event_type_id/events/read
  describe 'GET /areas/:area_id/event_types/:event_type_id/events/read' do
    before { get "/areas/#{area_id}/event_types/#{event_type_id}/events/read", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns read events' do
          expect(json).to be_empty
        end
      end

      context 'when area does not exist' do
        let(:area_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Area/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /sensors/:sensor_id/events
  describe 'GET /sensors/:sensor_id/events' do
    before { get "/sensors/#{sensor_id}/events", headers: header }

    context 'when api key is valid' do
      context 'when sensor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when sensor does not exist' do
        let(:sensor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Sensor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /sensors/:sensor_id/events/unread
  describe 'GET /sensors/:sensor_id/events/unread' do
    before { get "/sensors/#{sensor_id}/events/unread", headers: header }

    context 'when api key is valid' do
      context 'when sensor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns unread events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when sensor does not exist' do
        let(:sensor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Sensor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /sensors/:sensor_id/events/read
  describe 'GET /sensors/:sensor_id/events/read' do
    before { get "/sensors/#{sensor_id}/events/read", headers: header }

    context 'when api key is valid' do
      context 'when sensor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns read events' do
          expect(json).to be_empty
        end
      end

      context 'when sensor does not exist' do
        let(:sensor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Sensor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /event_types/:event_type_id/events
  describe 'GET /event_types/:event_type_id/events' do
    before { get "/event_types/#{event_type_id}/events", headers: header }

    context 'when api key is valid' do
      context 'when event type exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when event type does not exist' do
        let(:event_type_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find EventType/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /event_types/:event_type_id/events/unread
  describe 'GET /event_types/:event_type_id/events/unread' do
    before { get "/event_types/#{event_type_id}/events/unread", headers: header }

    context 'when api key is valid' do
      context 'when event type exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns unread events' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when event type does not exist' do
        let(:event_type_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find EventType/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /event_types/:event_type_id/events/read
  describe 'GET /event_types/:event_type_id/events/read' do
    before { get "/event_types/#{event_type_id}/events/read", headers: header }

    context 'when api key is valid' do
      context 'when event type exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns read events' do
          expect(json).to be_empty
        end
      end

      context 'when event type does not exist' do
        let(:event_type_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find EventType/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /areas/:area_id/events/:id
  describe 'GET /areas/:area_id/events/:id' do
    before { get "/areas/#{area_id}/events/#{event_id}", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        context 'when the event exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the event' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(event_id)
          end
        end
    
        context 'when the event does not exist' do
          let(:event_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Event/)
          end
        end
      end

      context 'when area does not exist' do
        let(:area_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Area/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/events/:id
  describe 'GET /floors/:floor_id/events/:id' do
    before { get "/floors/#{floor_id}/events/#{event_id}", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        context 'when the event exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the events' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(event_id)
          end
        end
    
        context 'when the event does not exist' do
          let(:event_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Event/)
          end
        end
      end

      context 'when floor does not exist' do
        let(:floor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Floor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /sensors/:sensor_id/events/:id
  describe 'GET /sensors/:sensor_id/events/:id' do
    before { get "/sensors/#{sensor_id}/events/#{event_id}", headers: header }

    context 'when api key is valid' do
      context 'when sensor exists' do
        context 'when the event exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the event' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(event_id)
          end
        end
    
        context 'when the event does not exist' do
          let(:event_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Event/)
          end
        end
      end

      context 'when sensor does not exist' do
        let(:sensor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Sensor/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for GET /event_types/:event_type_id/events/:id
  describe 'GET /event_types/:event_type_id/events/:id' do
    before { get "/event_types/#{event_type_id}/events/#{event_id}", headers: header }

    context 'when api key is valid' do
      context 'when event type exists' do
        context 'when the event exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the event' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(event_id)
          end
        end
    
        context 'when the event does not exist' do
          let(:event_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Event/)
          end
        end
      end

      context 'when event_type does not exist' do
        let(:event_type_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find EventType/)
        end
      end
    end

    context 'when api key is invalid' do
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end

  # Test suite for POST /sensors/:sensor_id/events
  describe 'POST /sensors/:sensor_id/events' do
    let(:valid_attributes) { { event_type_id: event_type_id, state: 'unread' } }

    context 'when api key is valid' do
      context 'when sensor exists' do
        context 'when the request is valid' do
          before { post "/sensors/#{sensor_id}/events", params: valid_attributes, headers: header_sensor }
    
          it 'returns status code 201' do
            expect(response).to have_http_status(201)
          end
          it 'creates an event' do
            expect(json['event_type_id']).to eq(event_type_id)
            expect(json['state']).to eq('unread')
          end
        end
    
        context 'when the request is invalid' do
          before { post "/sensors/#{sensor_id}/events", params: { event_type_id: event_type_id }, headers: header_sensor }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
          it 'returns a validation failure message' do
            expect(response.body)
              .to match(/Validation failed: State can't be blank/)
          end
        end
    
        context 'when the request is invalid' do
          before { post "/sensors/#{sensor_id}/events", params: { state: 'unread' }, headers: header_sensor }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
          it 'returns a validation failure message' do
            expect(response.body)
              .to match(/Validation failed: Event type must exist/)
          end
        end
      end

      context 'when sensor does not exist' do
        before { post "/sensors/#{sensor_id}/events", params: valid_attributes, headers: header_sensor }

        let(:sensor_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Sensor/)
        end
      end
    end

    context 'when api key is invalid' do
      before { post "/sensors/#{sensor_id}/events", params: valid_attributes, headers: invalid_header }
      
      let(:header) { invalid_header }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an authorization error message' do
        expect(response.body).to match(/Authorization failed/)
      end
    end
  end
end