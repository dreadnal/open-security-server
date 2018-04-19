require 'rails_helper'

RSpec.describe 'Areas API', type: :request do
  let!(:floor) { create(:floor) }
  let!(:areas) { create_list(:area, 10, floor_id: floor.id) }
  let(:floor_id) { floor.id }
  let(:id) { areas.first.id }

  # Test suite for GET /areas
  describe 'GET /areas' do
    before { get "/areas" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns areas' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end   
  end

  # Test suite for GET /floors/:floor_id/areas
  describe 'GET /floors/:floor_id/areas' do
    before { get "/floors/#{floor_id}/areas" }

    context 'when floor exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns areas' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
    end

    context 'when area does not exist' do
      let(:floor_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Floor/)
      end
    end
  end

  # Test suite for GET /floors/:floor_id/areas/:id
  describe 'GET /floors/:floor_id/areas/:id' do
    before { get "/floors/#{floor_id}/areas/#{id}" }
  
    context 'when area exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
  
      it 'returns the area' do
        expect(json['id']).to eq(id)
      end
    end
  
    context 'when area does not exist' do
      let(:id) { 0 }
  
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
  
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Area/)
      end
    end
  end

  # Test suite for GET /areas/:id
  describe 'GET /areas/:id' do
    before { get "/areas/#{id}" }
  
    context 'when area exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
  
      it 'returns the area' do
        expect(json['id']).to eq(id)
      end
    end
  
    context 'when area does not exist' do
      let(:id) { 0 }
  
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
  
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Area/)
      end
    end
  end
  
  # Test suite for PUT /floors/:floor_id/areas
  describe 'POST /floors/:floor_id/areas' do
    let(:valid_attributes) { { name: 'Test area', data: 'test data' } }

    context 'when request attributes are valid' do
      before { post "/floors/#{floor_id}/areas", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/floors/#{floor_id}/areas", params: { name: 'Test area' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Data can't be blank/)
      end
    end

    context 'when an invalid request' do
      before { post "/floors/#{floor_id}/areas", params: { data: 'test data' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /floors/:floor_id/areas/:id
  describe 'PUT /floors/:floor_id/areas/:id' do
    let(:valid_attributes) { { name: 'Changed test area', data: 'changed test data' } }

    before { put "/floors/#{floor_id}/areas/#{id}", params: valid_attributes }

    context 'when area exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the area' do
        updated_area = Area.find(id)
        expect(updated_area.name).to match(/Changed test area/)
        expect(updated_area.data).to match(/changed test data/)
      end
    end

    context 'when the area does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Area/)
      end
    end
  end

  # Test suite for DELETE /floors/:floor_id/areas/:id
  describe 'DELETE /floors/:floor_id/areas/:id' do
    before { delete "/floors/#{floor_id}/areas/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end