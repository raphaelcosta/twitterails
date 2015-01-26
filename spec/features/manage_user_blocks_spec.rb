require 'rails_helper'

feature 'Manage users block', %q{
  As an user
  I want to block other user
  In order to other user dont follow me and see my messages
} do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  background do
    sign_in user
    click_link 'Users'
  end

  feature 'block other user' do
    scenario 'it must change block status' do
      within(".user-#{other_user.id}") do
        click_link 'Block'
      end

      expect(page).to_not have_button('Block')
      expect(page).to have_text("You blocked #{other_user.username}")
    end
  end

  feature 'unblock other user' do
    background do
      user.block(other_user)
      visit users_path
    end

    scenario 'it must change block status after click unblock button' do
      within(".user-#{other_user.id}") do
        click_link 'Unblock'
      end

      expect(page).to_not have_button('Unblock')
      expect(page).to have_text("You unblocked #{other_user.username}")
    end
  end
end
