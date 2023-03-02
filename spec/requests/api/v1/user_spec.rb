require 'rails_helper'

RSpec.describe "User API v1", type: :request do
  let(:version) { 'v1' }

  describe "POST /create" do
    let(:params) { { email: 'jill.user@test.com', password: 'fakepassword' } }
    let(:action) { post api_users_path(version), params: params }

    context 'with valid params' do
      it 'succeeds and returns JSON' do
        expect { action }.to_not raise_error
        expect(response.status).to eq(200)
      end
    end
  end
end
