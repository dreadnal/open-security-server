require 'rails_helper'

RSpec.describe 'EventTypes API', type: :request do
  let!(:event_types) { create_list(:event_type, 10) }
  let(:event_type_id) { event_types.first.id }
  let!(:device) { create(:device) }
  let(:header) { { 'Authorization' => device.api_key } }
  let(:invalid_header) { { 'Authorization' => 'foo bar' } }

  # Test suite for GET /event_types
  describe 'GET /event_types' do
    before { get '/event_types', headers: header }

    context 'when api key is valid' do  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns event types' do
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

  # Test suite for GET /event_types/:id
  describe 'GET /event_types/:id' do
    before { get "/event_types/#{event_type_id}", headers: header }

    context 'when api key is valid' do  
      context 'when the event type exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns the event type' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(event_type_id)
        end
      end
  
      context 'when the event type does not exist' do
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
end