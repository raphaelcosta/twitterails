require 'rails_helper'

describe User do
  describe '#follow' do
    it 'should return false if try to follow itself' do
      user = build(:user)
      expect(user.follow(user)).to be false
    end

    it 'should follow another user' do
      user = create(:user)
      other_user = create(:user)

      user.follow(other_user)
      expect(user.following).to include(other_user)
    end

    context 'when user already follow the user' do
      it 'dont follow twice' do
        user = create(:user)
        other_user = create(:user)
        user.follow(other_user)
        user.follow(other_user)
        expect(user.following.size).to eq(1)
      end
    end
  end

  describe '#following?' do
    context 'when user dont follow other user' do
      it 'should return false' do
        user = create(:user)
        other_user = create(:user)
        expect(user.following?(other_user)).to be false
      end
    end

    context 'when user already follow other user' do
      it 'should return true' do
        user = create(:user)
        other_user = create(:user)
        user.follow(other_user)

        expect(user.following?(other_user)).to be true
      end
    end
  end

  describe '#unfollow' do
    context 'when user follow other user' do
      it 'must remove user from follow list' do
        user = create(:user)
        other_user = create(:user)
        user.follow(other_user)
        user.unfollow(other_user)

        expect(user.following?(other_user)).to be false
      end
    end

    context "when user don't follow other user" do
      it 'must return false' do
        user = create(:user)
        other_user = create(:user)
        result = user.unfollow(other_user)

        expect(result).to be false
        expect(user.following?(other_user)).to be false
      end
    end
  end
end
