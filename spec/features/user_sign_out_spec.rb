require 'rails_helper'

RSpec.feature 'Signing out signed-in users' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    visit '/'
    click_link('Sign in')
    fill_in('Email', with: @john.email)
    fill_in('Password', with: @john.password)
    click_button('Log in')
  end

  # Defining scenario
  scenario 'User sign out successful' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link('Sign out')

    # Coming from Capybara -- expectations
    expect(page).to have_content('Signed out successfully.')
    expect(page).not_to have_content('Sign out')
  end
end
