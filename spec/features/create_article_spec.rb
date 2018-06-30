require 'rails_helper'

RSpec.feature 'Creating Articles' do
  # Defining scenario
  scenario 'A user creates a new article' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link('New Article')
    fill_in('Title', with: 'Creating a blog')
    fill_in('Body', with: 'Lorem Ipsum')
    click_button('Create Article')

    # Coming from Capybara -- expectations
    expect(page).to have_content('Article has been created')
    expect(page.current_path).to eq(articles_path)
  end
end
