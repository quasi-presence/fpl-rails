require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:version) { 'v1' }

  describe "POST /auth/login" do
    let!(:user) { FactoryBot.create(:user, email: 'jill.user@test.com', password: 'fakepassword') }
    let(:action) { post auth_login_path, params: params }

    context 'with valid credentials' do
      let(:params) { { 'email' => 'jill.user@test.com', 'password' => 'fakepassword' } }

      it 'succeeds and returns token' do
        expect { action }.to_not raise_error
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['token']).to_not be_nil
      end
    end

    context 'with invalid credentials' do
      let(:params) { { 'email' => 'jill.user@test.com', 'password' => 'wrongpassword' } }

      it 'returns error' do
        expect { action }.to_not raise_error
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)).to eq({ 'errors' => ['Unauthorized'] })
      end
    end
  end
end

