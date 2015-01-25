require 'rails_helper'

feature 'Edit account', %q{
  As an user
  I want to edit my account
  In order to update my user info
} do

  let!(:user) { create(:user) }

  background do
    sign_in user
    visit edit_account_path
  end

  scenario 'with valid info' do
    fill_in 'Name', with: 'João'
    fill_in 'Email', with: 'joao@gmail.com'
    fill_in 'Username', with: 'joao_carlos'
    fill_in 'Password', with: 'password'
    click_button 'Update my account'

    expect(page).to have_text('Your account have been successfully updated.')
    expect(page).to have_text('João')
    expect(page).to have_text('joao@gmail.com')
    expect(page).to have_text('joao_carlos')
  end

  scenario 'with invalid username' do
    fill_in 'Username', with: 'joao,carlos'
    click_button 'Update my account'

    expect(page).to have_text('Username is invalid')
  end

  scenario 'with blank name' do
    fill_in 'Name', with: ''
    click_button 'Update my account'

    expect(page).to have_text("Name can't be blank")
  end

  scenario 'with invalid password' do
    fill_in 'Password', with: ''
    click_button 'Update my account'

    expect(page).to have_text("Password can't be blank")
  end

  scenario 'with invalid email' do
    fill_in 'Email', with: 'joao@gmail'
    click_button 'Update my account'

    expect(page).to have_text("Email is invalid")
  end
end
