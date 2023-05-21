require 'rails_helper'

RSpec.describe Api::V1::UpdateUser, type: :service do
  describe '.call' do
    let!(:user) { FactoryBot.create(:user, email: 'jill.user@test.com', image_url: '/2022_image.png') }
    let(:result) { Api::V1::UpdateUser.call(params) }

    context 'with valid params' do
      let(:params) { { 'id' => user.id, 'email' => 'jill.client@test.com', 'imageUrl' => '/2023_image.png' } }

      it 'updates user and returns data' do
        expect { result }.to_not change { User.count }

        # Updates user
        user.reload
        expect(user.email).to eq(params['email'])
        expect(user.image_url).to eq(params['imageUrl'])

        # Returns results
        expect(result).to eq({
          'id' => user.id,
          'email' => user.email,
          'imageUrl' => user.image_url
        })
      end
    end

    context 'with invalid params' do
      let(:params) { { 'id' => user.id, 'email' => '' } }

      it 'fails to create user and returns errors' do
        expect { result }.to change { User.count }.by(0)
        expect(result).to eq({ 'errors' => ["Email can't be blank"] })
      end
    end

    context 'no user exists' do
      let(:params) { { 'id' => user.id + 100, 'email' => 'jill.client@test.com' } }

      it 'fails to create user and returns errors' do
        expect { result }.to change { User.count }.by(0)
        expect(result).to eq({ 'errors' => ["Not found"] })
      end
    end
  end
end
