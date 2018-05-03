require 'rails_helper'

RSpec.describe 'Floors API', type: :request do
  let!(:floors) { create_list(:floor, 10) }
  let(:floor_id) { floors.first.id }
  let!(:device) { create(:device) }
  let(:api_key) { device.verify(device.one_time_password) }
  let(:header) { { 'Authorization' => api_key } }
  let(:invalid_header) { { 'Authorization' => 'foo bar' } }

  # Test suite for GET /floors
  describe 'GET /floors' do
    before { get '/floors', headers: header }

    context 'when api key is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns floors' do
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

  # Test suite for GET /floors/:id
  describe 'GET /floors/:id' do
    before { get "/floors/#{floor_id}", headers: header }

    context 'when api key is valid' do
      context 'when the floor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns the floor' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(floor_id)
        end
      end

      context 'when the floor does not exist' do
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
end