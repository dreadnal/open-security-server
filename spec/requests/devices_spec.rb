require 'rails_helper'

RSpec.describe 'Devices API', type: :request do
  let!(:device) { create(:device) }
  let!(:invalid_device) { create(:device) }
  let(:id) { device.id }
  let(:invalid_id) { invalid_device.id }
  let(:one_time_password) { device.one_time_password }

  # Test suite for POST /devices/:id/verify
  describe 'POST /devices/:id/verify' do
    before { post "/devices/#{id}/verify", params: { one_time_password: one_time_password } }

    context 'when one time password is valid' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns api key' do
        expect(json).not_to be_empty
      end
    end

    context 'when one time password is invalid' do
      let(:id) { invalid_id }
      let(:one_time_password) { "foobar" }
      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
      it 'returns an verification error message' do
        expect(response.body).to match(/Verification failed/)
      end
    end
  end
end