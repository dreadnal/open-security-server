require 'rails_helper'

RSpec.describe 'Cameras API', type: :request do
  let!(:floor) { create(:floor) }
  let!(:area) { create(:area, floor_id: floor.id) }
  let!(:cameras) { create_list(:camera, 10, area_id: area.id) }
  let(:floor_id) {floor.id}
  let(:area_id) {area.id}
  let(:camera_id) { cameras.first.id }

  # Test suite for GET /floors/:floor_id/cameras
  describe 'GET /floors/:floor_id/cameras' do
    before { get "/floors/#{floor_id}/cameras" }

    it 'returns cameras' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/cameras
  describe 'GET /areas/:area_id/cameras' do
    before { get "/areas/#{area_id}/cameras" }

    it 'returns cameras' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /cameras
  describe 'GET /cameras' do
    before { get '/cameras' }

    it 'returns cameras' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /areas/:area_id/cameras/:id
  describe 'GET /areas/:area_id/cameras/:id' do
    before { get "/areas/#{area_id}/cameras/#{camera_id}" }

    context 'when the record exists' do
      it 'returns the cameras' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(camera_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:camera_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
 
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Camera/)
      end
    end
  end

  # Test suite for POST /areas/:area_id/cameras
  describe 'POST /areas/:area_id/cameras' do
    let(:valid_attributes) { { name: 'Test camera', address: '127.0.0.1', note: 'test camera note', data: 'test camera data' } }

    context 'when the request is valid' do
      before { post "/areas/#{area_id}/cameras", params: valid_attributes }

      it 'creates a cameras' do
        expect(json['name']).to eq('Test camera')
        expect(json['address']).to eq('127.0.0.1')
        expect(json['note']).to eq('test camera note')
        expect(json['data']).to eq('test camera data')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/areas/#{area_id}/cameras", params: { address: '127.0.0.1', note: 'test camera note', data: 'test camera data' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post "/areas/#{area_id}/cameras", params: { name: 'Test camera', note: 'test camera note', data: 'test camera data' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Address can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post "/areas/#{area_id}/cameras", params: { name: 'Test camera', address: '127.0.0.1', data: 'test camera data' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Note can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post "/areas/#{area_id}/cameras", params: { name: 'Test camera', address: '127.0.0.1', note: 'test camera note' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Data can't be blank/)
      end
    end
  end

  # Test suite for PUT /areas/:area_id/cameras/:id
  describe 'PUT /areas/:area_id/cameras/:id' do
    let(:valid_attributes) { { name: 'Second test camera', address: 'localhost', note: 'second test camera note', data: 'second test camera data' } }

    context 'when the record exists' do
      before { put "/areas/#{area_id}/cameras/#{camera_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /cameras/:id
  describe 'DELETE /areas/:area_id/cameras/:id' do
    before { delete "/areas/#{area_id}/cameras/#{camera_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end