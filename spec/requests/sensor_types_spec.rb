require 'rails_helper'

RSpec.describe 'SensorTypes API', type: :request do
  let!(:sensor_types) { create_list(:sensor_type, 10) }
  let(:sensor_type_id) { sensor_types.first.id }

  # Test suite for GET /sensor_types
  describe 'GET /sensor_types' do
    before { get '/sensor_types' }

    it 'returns sensor_types' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sensor_types/:id
  describe 'GET /sensor_types/:id' do
    before { get "/sensor_types/#{sensor_type_id}" }

    context 'when the record exists' do
      it 'returns the sensor_types' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(sensor_type_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:sensor_type_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find SensorType/)
      end
    end
  end

  # Test suite for POST /sensor_types
  describe 'POST /sensor_types' do
    let(:valid_attributes) { { name: 'Test sensor type', icon: 'default', model: 'default', note: 'sensor type note' } }

    context 'when the request is valid' do
      before { post '/sensor_types', params: valid_attributes }

      it 'creates a sensor_types' do
        expect(json['name']).to eq('Test sensor type')
        expect(json['icon']).to eq('default')
        expect(json['model']).to eq('default')
        expect(json['note']).to eq('sensor type note')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/sensor_types', params: { name: 'Test sensor type', model: 'default', note: 'sensor type note' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Icon can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/sensor_types', params: { icon: 'default', model: 'default', note: 'sensor type note' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
    context 'when the request is invalid' do
      before { post '/sensor_types', params: { name: 'Test sensor type', icon: 'default', note: 'sensor type note' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Model can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/sensor_types', params: { name: 'Test sensor type', icon: 'default', model: 'default' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Note can't be blank/)
      end
    end
  end

  # Test suite for PUT /sensor_types/:id
  describe 'PUT /sensor_types/:id' do
    let(:valid_attributes) { { name: 'Second test sensor type', icon: 'alterne', model: 'alterne', note: 'second sensor type note' } }

    context 'when the record exists' do
      before { put "/sensor_types/#{sensor_type_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /sensor_types/:id
  describe 'DELETE /sensor_types/:id' do
    before { delete "/sensor_types/#{sensor_type_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end