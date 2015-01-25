require 'rails_helper'

feature 'Authenticate', %q{
  As an user
  I want to authenticate using my credentials
  In order to see my friends posts and add new post
} do

  scenario 'with valid username and password' do
    user = create(:user)
    login_with user.username, user.password
    expect(page).to have_text('You have been successfully logged in')
  end

  scenario 'with invalid username' do
    login_with 'jondoe', 'john123'
    expect(page).to have_text('Invalid username or password')
  end

  scenario 'with invalid password' do
    user = create(:user)
    login_with user.username, 'wrong-password'
    expect(page).to have_text('Invalid username or password')
  end

  def login_with(username, password)
    visit login_path
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_button 'Sign in'
  end
end
