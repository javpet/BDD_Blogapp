require 'rails_helper'

RSpec.feature 'Signing up users' do
  # Defining scenario
  scenario 'User sign up successful' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: 'user@example.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_button('Sign up')

    # Coming from Capybara -- expectations
    expect(page).to have_content('You have signed up successfully.')
  end

  scenario 'User sign up not successful' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: '')
    fill_in('Password', with: '')
    fill_in('Password confirmation', with: '')
    click_button('Sign up')

    # Coming from Capybara -- expectations
    # expect(page).to have_content('You have not signed up successfully.')
  end
end
