require 'rails_helper'

RSpec.describe 'Floors API', type: :request do
  let!(:floors) { create_list(:floor, 10) }
  let(:floor_id) { floors.first.id }

  # Test suite for GET /floors
  describe 'GET /floors' do
    before { get '/floors' }

    it 'returns floors' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /floors/:id
  describe 'GET /floors/:id' do
    before { get "/floors/#{floor_id}" }

    context 'when the record exists' do
      it 'returns the floor' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(floor_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:floor_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Floor/)
      end
    end
  end

  # Test suite for POST /floors
  describe 'POST /floors' do
    let(:valid_attributes) { { name: 'Test floor', position: 1, data: 'test data' } }

    context 'when the request is valid' do
      before { post '/floors', params: valid_attributes }

      it 'creates a floor' do
        expect(json['name']).to eq('Test floor')
        expect(json['position']).to eq(1)
        expect(json['data']).to eq('test data')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/floors', params: { name: 'Test floor', position: 1 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Data can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/floors', params: { name: 'Test floor', data: 'test data' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Position can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/floors', params: { position: 1, data: 'test data' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /floors/:id
  describe 'PUT /floors/:id' do
    let(:valid_attributes) { { name: 'Second test floor', position: 2 } }

    context 'when the record exists' do
      before { put "/floors/#{floor_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /floors/:id
  describe 'DELETE /floors/:id' do
    before { delete "/floors/#{floor_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end