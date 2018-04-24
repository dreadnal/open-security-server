require 'rails_helper'

RSpec.describe 'Cameras API', type: :request do
  let!(:floor) { create(:floor) }
  let!(:area) { create(:area, floor_id: floor.id) }
  let!(:cameras) { create_list(:camera, 10, area_id: area.id) }
  let(:floor_id) {floor.id}
  let(:area_id) {area.id}
  let(:camera_id) { cameras.first.id }
  let!(:device) { create(:device) }
  let(:header) { { 'Authorization' => device.api_key } }
  let(:invalid_header) { { 'Authorization' => 'foo bar' } }

  # Test suite for GET /cameras
  describe 'GET /cameras' do
    before { get "/cameras", headers: header }

    context 'when api key is valid' do  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns cameras' do
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

  # Test suite for GET /floors/:floor_id/cameras
  describe 'GET /floors/:floor_id/cameras' do
    before { get "/floors/#{floor_id}/cameras", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns cameras' do
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

  # Test suite for GET /areas/:area_id/cameras
  describe 'GET /areas/:area_id/cameras' do
    before { get "/areas/#{area_id}/cameras", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns cameras' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end
    
      context 'when area does not exist' do
        let(:area_id) { 0 }
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

  # Test suite for GET /areas/:area_id/cameras/:id
  describe 'GET /areas/:area_id/cameras/:id' do
    before { get "/areas/#{area_id}/cameras/#{camera_id}", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        context 'when the camera exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the camera' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(camera_id)
          end
        end
    
        context 'when the camera does not exist' do
          let(:camera_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Camera/)
          end
        end
      end
    
      context 'when area does not exist' do
        let(:area_id) { 0 }
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

  # Test suite for GET /floors/:floor_id/cameras/:id
  describe 'GET /floors/:floor_id/cameras/:id' do
    before { get "/floors/#{floor_id}/cameras/#{camera_id}", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        context 'when the camera exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the camera' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(camera_id)
          end
        end
    
        context 'when the camera does not exist' do
          let(:camera_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Camera/)
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
end