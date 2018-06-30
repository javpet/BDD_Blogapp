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

  scenario 'A user fails to create new article' do
    visit '/'
    click_link('New Article')
    fill_in('Title', with: '')
    fill_in('Body', with: '')
    click_button('Create Article')

    # Coming from Capybara -- expectations
    expect(page).to have_content('Article has not been created')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
