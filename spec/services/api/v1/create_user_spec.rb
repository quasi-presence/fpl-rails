require 'rails_helper'

RSpec.describe Api::V1::CreateUser, type: :service do
  describe '.call' do
    let(:result) { Api::V1::CreateUser.call(params) }

    context 'with valid params' do
      let(:params) { { 'email' => 'joe.user@test.com', 'password_digest' => 'fakepassword' } }

      it 'creates user and returns data' do
        expect { result }.to change { User.count }.by(1)

        user = User.find_by(email: params['email'])
        expect(result).to eq({
          'id' => user.id,
          'email' => user.email,
          'imageUrl' => user.image_url,
          'created_at' => user.created_at,
          'updated_at' => user.updated_at
        })
      end
    end

    context 'with invalid params' do
      let(:params) { { 'email' => 'joe.user@test.com', 'password_digest' => nil } }

      it 'fails to create user and returns errors' do
        expect { result }.to change { User.count }.by(0)

        user = User.find_by(email: params['email'])
        expect(result).to eq({ 'errors' => ["Password can't be blank"] })
      end
    end
  end
end
