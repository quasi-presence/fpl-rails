require 'rails_helper'

RSpec.describe "User API v1", type: :request do
  let(:version) { 'v1' }

  describe "POST /create" do
    let(:params) { { 'email' => 'jill.user@test.com', 'password' => 'fakepassword' } }
    let(:action) { post api_users_path(version), params: params }

    context 'with valid params' do
      it 'succeeds and returns JSON' do
        expect { action }.to_not raise_error
        expect(response.status).to eq(200)
      end
    end
  end

  describe "PUT /update" do
    let(:user) { FactoryBot.create(:user, email: 'jill.user@test.com', image_url: '/2022_image.png') }
    let(:api_token) { JWT.encode({ user_id: user.id, exp: 1.day.from_now.to_i }, Rails.application.secret_key_base) }
    let(:headers) { { 'Authorization' => api_token }}
    let(:params) { { 'email' => 'jill.client@test.com', 'imageUrl' => '/2023_image.png' } }
    let(:action) { put api_user_path(version, user), headers: headers, params: params }

    context 'with valid params' do
      it 'succeeds and returns JSON' do
        expect { action }.to_not raise_error

        # Updates user
        user.reload
        expect(user.email).to eq(params['email'])
        expect(user.image_url).to eq(params['imageUrl'])

        expect(response.status).to eq(200)
        expect(response.body).to eq({
          id: user.id,
          email: user.email,
          imageUrl: user.image_url
        }.to_json)
      end
    end
  end
end
