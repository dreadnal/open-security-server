require 'rails_helper'

RSpec.describe 'SensorTypes API', type: :request do
  let!(:sensor_types) { create_list(:sensor_type, 10) }
  let(:sensor_type_id) { sensor_types.first.id }
  let!(:device) { create(:device) }
  let(:header) { { 'Authorization' => device.api_key } }
  let(:invalid_header) { { 'Authorization' => 'foo bar' } }

  # Test suite for GET /sensor_types
  describe 'GET /sensor_types' do
    before { get '/sensor_types', headers: header }

    context 'when api key is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns sensor types' do
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

  # Test suite for GET /sensor_types/:id
  describe 'GET /sensor_types/:id' do
    before { get "/sensor_types/#{sensor_type_id}", headers: header }

    context 'when api key is valid' do
      context 'when the sensor type exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns the sensor type' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(sensor_type_id)
        end
      end
  
      context 'when the sensor type does not exist' do
        let(:sensor_type_id) { 0 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find SensorType/)
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