require 'rails_helper'

feature 'Signup', %q{
  As an user
  I want to create my account
  In order to post and follow other people
} do

  scenario 'with valid info' do
    sign_up_with 'John Doe', 'john@doe.com', 'john_doe', 'password'
    expect(page).to have_text('Your account have been successfully created')
  end

  scenario 'with invalid username' do
    sign_up_with 'John Doe', 'john@doe.com', '@john_doe', 'password'
    expect(page).to have_text('Username is invalid')
  end

  scenario 'with blank name' do
    sign_up_with '', 'john@doe.com', 'john_doe', 'password'
    expect(page).to have_text("Name can't be blank")
  end

  scenario 'with invalid password' do
    sign_up_with 'John Doe', 'john@doe.com', 'john_doe', ''
    expect(page).to have_text("Password can't be blank")
  end

  scenario 'with invalid email' do
    sign_up_with 'John Doe', 'john@doe', 'john_doe', 'password'
    expect(page).to have_text("Email is invalid")
  end

  def sign_up_with(name, email, username, password)
    visit new_signup_path
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_button 'Sign up'
  end
end
