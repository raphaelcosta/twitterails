require 'rails_helper'

feature 'View profile spec', %q{
  As an user
  I want to see other user profiles and messages
  In order to decide which one I want to follow
} do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:message) { create(:message, user: other_user) }

  background do
    sign_in user
    click_link 'Users'
    click_link other_user.name
  end

  scenario 'it must show other user messages' do
    expect(page).to have_text(message.content)
  end

  feature 'blocked user' do
    background do
      other_user.block user
      visit user_path(other_user)
    end

    scenario 'it must redirect and not show user profile' do
      expect(page).to have_text('This user is not avaliable')
    end
  end
end
