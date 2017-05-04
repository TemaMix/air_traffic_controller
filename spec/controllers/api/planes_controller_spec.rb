require 'rails_helper'

RSpec.describe Api::PlanesController, type: :controller do

  describe 'POST #create' do
    it 'check routing for controller' do
      expect(:post => '/api/planes').to route_to('api/planes#create')
    end
    context 'check controller response' do
      it 'returns http success' do
        post :create, format: :json
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('plane')
      end
    end
  end

end