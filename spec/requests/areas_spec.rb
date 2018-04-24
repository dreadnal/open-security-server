require 'rails_helper'

RSpec.describe 'Areas API', type: :request do
  let!(:floor) { create(:floor) }
  let!(:areas) { create_list(:area, 10, floor_id: floor.id) }
  let(:floor_id) { floor.id }
  let(:id) { areas.first.id }
  let!(:device) { create(:device) }
  let(:header) { { 'Authorization' => device.api_key } }
  let(:invalid_header) { { 'Authorization' => 'foo bar' } }

  # Test suite for GET /areas
  describe 'GET /areas' do
    before { get "/areas", headers: header }

    context 'when api key is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns areas' do
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

  # Test suite for GET /floors/:floor_id/areas
  describe 'GET /floors/:floor_id/areas' do
    before { get "/floors/#{floor_id}/areas", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns areas' do
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

  # Test suite for GET /floors/:floor_id/areas/:id
  describe 'GET /floors/:floor_id/areas/:id' do
    before { get "/floors/#{floor_id}/areas/#{id}", headers: header }
  
    context 'when api key is valid' do
      context 'when floor exists' do
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

  # Test suite for GET /areas/:id
  describe 'GET /areas/:id' do
    before { get "/areas/#{id}", headers: header }
  
    context 'when api key is invalid' do
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