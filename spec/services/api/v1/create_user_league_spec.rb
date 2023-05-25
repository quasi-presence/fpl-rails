require 'rails_helper'

RSpec.describe Api::V1::CreateUserLeague, type: :service do
  describe '.call' do
    let(:user) { FactoryBot.create(:user) }
    let(:result) { Api::V1::CreateUserLeague.call(params) }

    context 'with valid params' do
      let(:params) { { 'name' => 'Fast & Furious', 'owner_id' => user.id } }

      it 'creates user league and returns data' do
        expect { result }.to change { UserLeague.count }.by(1)

        user_league = UserLeague.find_by(owner_id: user.id, name: params['name'])
        expect(result).to eq({
          'id' => user_league.id,
          'name' => user_league.name,
          'imageUrl' => user_league.image_url
        })
      end
    end

    context 'with invalid params' do
      let(:params) { { 'name' => nil, 'owner_id' => user.id } }

      it 'fails to create user league and returns errors' do
        expect { result }.to change { UserLeague.count }.by(0)
        expect(result).to eq({ 'errors' => ["Name can't be blank"] })
      end
    end
  end
end
