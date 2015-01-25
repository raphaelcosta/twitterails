require 'rails_helper'

feature 'Manage user follows', %q{
  As an user
  I want to follow and unfollow other users
  In order to decide which one I want to see posts
} do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  background do
    sign_in user
    click_link 'Users'
  end

  feature 'follow other user' do
    scenario 'it must change follow status after click follow button' do
      within(".user-#{other_user.id}") do
        click_link 'Follow'
      end

      expect(page).to_not have_button('Follow')
      expect(page).to have_text("Now you are following #{other_user.username}")
    end
  end

  feature 'unfollow other user' do
    background do
      user.follow(other_user)
      visit users_path
    end

    scenario 'it must change follow status after click unfollow button' do
      within(".user-#{other_user.id}") do
        click_link 'Unfollow'
      end

      expect(page).to_not have_button('Unfollow')
      expect(page).to have_text("You unfollowed #{other_user.username}")
    end
  end
end
