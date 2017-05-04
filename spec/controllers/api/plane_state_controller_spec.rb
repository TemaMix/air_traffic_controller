require 'rails_helper'

RSpec.describe Api::PlaneStateController, type: :controller do

  let(:plane) { create :plane }

  describe 'PUT #update' do
    it 'check routing for controller' do
      expect(:put => "/api/planes/state/#{plane.id}").to route_to( controller: 'api/plane_state',action:'update', id: plane.id.to_s)
    end
    context 'check controller response' do
      it 'returns http success' do
        put :update, params:{id: plane.id}, format: :json
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('plane')
      end
    end
  end

end