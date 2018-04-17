require 'rails_helper'

RSpec.describe 'EventTypes API', type: :request do
  let!(:event_types) { create_list(:event_type, 10) }
  let(:event_type_id) { event_types.first.id }

  # Test suite for GET /event_types
  describe 'GET /event_types' do
    before { get '/event_types' }

    it 'returns event_types' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /event_types/:id
  describe 'GET /event_types/:id' do
    before { get "/event_types/#{event_type_id}" }

    context 'when the record exists' do
      it 'returns the event_types' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_type_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_type_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find EventType/)
      end
    end
  end

  # Test suite for POST /event_types
  describe 'POST /event_types' do
    let(:valid_attributes) { { name: 'Test event type', icon: 'default' } }

    context 'when the request is valid' do
      before { post '/event_types', params: valid_attributes }

      it 'creates a event_types' do
        expect(json['name']).to eq('Test event type')
        expect(json['icon']).to eq('default')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/event_types', params: { name: 'Test event type' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Icon can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/event_types', params: { icon: 'default' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /event_types/:id
  describe 'PUT /event_types/:id' do
    let(:valid_attributes) { { name: 'Second test event type', icon: 'default' } }

    context 'when the record exists' do
      before { put "/event_types/#{event_type_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /event_types/:id
  describe 'DELETE /event_types/:id' do
    before { delete "/event_types/#{event_type_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end