require 'rails_helper'

describe UserLeague do
  describe '#valid?' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:existing_user_league) { FactoryBot.create(:user_league, owner: user, name: 'First League') }
    let(:user_league) { FactoryBot.build(:user_league, owner: user) }

    it 'requires owner' do
      user_league.owner = nil
      expect(user_league.valid?).to eq(false)
      expect(user_league.errors.full_messages).to include("Owner must exist")
    end

    it 'requires name' do
      user_league.name = nil
      expect(user_league.valid?).to eq(false)
      expect(user_league.errors.full_messages).to include("Name can't be blank")
    end

    it 'requires name is unique by owner' do
      user_league.name = existing_user_league.name
      expect(user_league.valid?).to eq(false)
      expect(user_league.errors.full_messages).to include("Name has already been taken")
    end
  end
end