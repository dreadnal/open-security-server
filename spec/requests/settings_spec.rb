require 'rails_helper'

RSpec.describe 'Settings API', type: :request do
  let!(:settings) { create_list(:setting, 10) }
  let(:setting_id) { settings.first.id }

  # Test suite for GET /settings
  describe 'GET /settings' do
    before { get '/settings' }

    it 'returns settings' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /settings/:id
  describe 'GET /settings/:id' do
    before { get "/settings/#{setting_id}" }

    context 'when the record exists' do
      it 'returns the settings' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(setting_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:setting_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Setting/)
      end
    end
  end

  # Test suite for POST /settings
  describe 'POST /settings' do
    let(:valid_attributes) { { name: 'Test setting', value: 'value' } }

    context 'when the request is valid' do
      before { post '/settings', params: valid_attributes }

      it 'creates a settings' do
        expect(json['name']).to eq('Test setting')
        expect(json['value']).to eq('value')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/settings', params: { name: 'Test setting' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Value can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/settings', params: { value: 'default' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /settings/:id
  describe 'PUT /settings/:id' do
    let(:valid_attributes) { { name: 'Second test setting', value: 'second value' } }

    context 'when the record exists' do
      before { put "/settings/#{setting_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /settings/:id
  describe 'DELETE /settings/:id' do
    before { delete "/settings/#{setting_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end