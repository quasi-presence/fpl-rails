require 'rails_helper'

RSpec.describe "UserLeague API v1", type: :request do
  let(:version) { 'v1' }

  describe "POST /create" do
    let!(:user) { FactoryBot.create(:user) }
    let(:api_token) { JWT.encode({ user_id: user.id, exp: 1.day.from_now.to_i }, Rails.application.secret_key_base) }
    let(:headers) { { 'Authorization' => api_token }}
    let(:params) { { 'name' => 'Fast & Furious', 'imageUrl' => '/2023_image.png' } }
    let(:action) { post api_user_leagues_path(version), headers: headers, params: params }

    context 'with valid params' do
      it 'succeeds and returns JSON' do
        expect { action }.to_not raise_error
        expect(response.status).to eq(200)

        response_json = JSON.parse(response.body)
        expect(response_json['id']).to_not be_nil
        expect(response_json['name']).to eq(params['name'])
        expect(response_json['imageUrl']).to eq(params['imageUrl'])
      end
    end
  end
end
