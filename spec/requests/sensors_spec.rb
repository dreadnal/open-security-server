require 'rails_helper'

RSpec.describe 'Sensor API', type: :request do
  let!(:floor) { create(:floor) }
  let!(:area) { create(:area, floor_id: floor.id) }
  let!(:sensor_type) { create(:sensor_type) }
  let!(:sensors) { create_list(:sensor, 10, area_id: area.id, sensor_type_id: sensor_type.id) }
  let(:floor_id) {floor.id}
  let(:area_id) {area.id}
  let(:sensor_type_id) {sensor_type.id}
  let(:sensor_id) { sensors.first.id }
  let!(:device) { create(:device) }
  let(:header) { { 'Authorization' => device.api_key } }
  let(:invalid_header) { { 'Authorization' => 'foo bar' } }

  # Test suite for GET /sensors
  describe 'GET /sensors' do
    before { get '/sensors', headers: header }

    context 'when api key is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns sensors' do
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

  # Test suite for GET /floors/:floor_id/sensors
  describe 'GET /floors/:floor_id/sensors' do
    before { get "/floors/#{floor_id}/sensors", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns sensors' do
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

  # Test suite for GET /areas/:area_id/sensors
  describe 'GET /areas/:area_id/sensors' do
    before { get "/areas/#{area_id}/sensors", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns sensors' do
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

  # Test suite for GET /sensor_types/:sensor_type_id/sensors
  describe 'GET /sensor_types/:sensor_type_id/sensors' do
    before { get "/sensor_types/#{sensor_type_id}/sensors", headers: header }

    context 'when api key is valid' do
      context 'when sensor type exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns sensors' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end

      context 'when sensor type does not exist' do
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

  # Test suite for GET /areas/:area_id/sensors/:id
  describe 'GET /areas/:area_id/sensors/:id' do
    before { get "/areas/#{area_id}/sensors/#{sensor_id}", headers: header }

    context 'when api key is valid' do
      context 'when area exists' do
        context 'when the record exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the sensors' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(sensor_id)
          end
        end
    
        context 'when the record does not exist' do
          let(:sensor_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Sensor/)
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

  # Test suite for GET /floors/:floor_id/sensors/:id
  describe 'GET /floors/:floor_id/sensors/:id' do
    before { get "/floors/#{floor_id}/sensors/#{sensor_id}", headers: header }

    context 'when api key is valid' do
      context 'when floor exists' do
        context 'when the record exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the sensors' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(sensor_id)
          end
        end
    
        context 'when the record does not exist' do
          let(:sensor_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Sensor/)
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

  # Test suite for GET /sensor_types/:sensor_type_id/sensors/:id
  describe 'GET /sensor_types/:sensor_type_id/sensors/:id' do
    before { get "/sensor_types/#{sensor_type_id}/sensors/#{sensor_id}", headers: header  }

    context 'when api key is valid' do
      context 'when sensor type exists' do
        context 'when the record exists' do
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
          it 'returns the sensors' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(sensor_id)
          end
        end
    
        context 'when the record does not exist' do
          let(:sensor_id) { 0 }
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Sensor/)
          end
        end
      end

      context 'when sensor type does not exist' do
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