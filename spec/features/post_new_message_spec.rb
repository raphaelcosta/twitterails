require 'rails_helper'

feature 'Post new message', %q{
  As an user
  I want to post new message
  In order to other users see my message
} do

  let!(:user) { create(:user) }

  background do
    sign_in user
  end

  scenario 'must publish message when message is not blank' do
    fill_in 'Your message', with: 'Olá, meu primeiro tweetrails'
    click_button 'Post'

    expect(page).to have_text('Your tweet have been published')

    visit user_path(user)
    expect(page).to have_text('Olá, meu primeiro tweetrails')
    expect(page).to have_text('less than a minute ago')
  end

  scenario 'when message is blank, must show error message' do
    click_button 'Post'
    expect(page).to have_text('Sorry, we are unable to post your tweet')
  end
end
