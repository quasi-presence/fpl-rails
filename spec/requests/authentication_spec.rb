require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:version) { 'v1' }

  describe "POST /auth/login" do
    let!(:user) { FactoryBot.create(:user, email: 'jill.user@test.com', image_url: '/image.png', password: 'fakepassword') }
    let(:action) { post auth_login_path, params: params }

    context 'with valid credentials' do
      let(:params) { { 'email' => 'jill.user@test.com', 'password' => 'fakepassword' } }

      it 'succeeds and returns token' do
        expect { action }.to_not raise_error
        expect(response.status).to eq(200)
        expect(response.headers['Access-Control-Expose-Headers']).to eq('Authorization')
        expect(response.headers['Authorization']).to_not be_nil
        expect(JSON.parse(response.body)['id']).to eq(user.id)
        expect(JSON.parse(response.body)['email']).to eq(user.email)
        expect(JSON.parse(response.body)['imageUrl']).to eq(user.image_url)
      end
    end

    context 'with invalid credentials' do
      let(:params) { { 'email' => 'jill.user@test.com', 'password' => 'wrongpassword' } }

      it 'returns error' do
        expect { action }.to_not raise_error
        expect(response.status).to eq(401)
        expect(response.headers['Authentication']).to be_nil
        expect(JSON.parse(response.body)).to eq({ 'errors' => ['Unauthorized'] })
      end
    end
  end
end

