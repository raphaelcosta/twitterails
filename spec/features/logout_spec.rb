require 'rails_helper'

feature 'Logout', %q{
  As an user
  I want to see logout
  In order to not leave my account authenticated
} do

  let!(:user) { create(:user) }

  background do
    sign_in user
  end

  scenario 'it must show successfull message' do
    click_link 'Logout'
    expect(page).to have_text('You have logged out successfully')
  end
end
