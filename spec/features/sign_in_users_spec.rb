require 'rails_helper'

RSpec.feature 'Signing in users' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
  end

  # Defining scenario
  scenario 'User sign in successful' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link('Sign in')
    fill_in('Email', with: @john.email)
    fill_in('Password', with: @john.password)
    click_button('Log in')

    # Coming from Capybara -- expectations
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end
end
