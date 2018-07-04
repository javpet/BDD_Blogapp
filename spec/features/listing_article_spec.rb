require 'rails_helper'

RSpec.feature 'Listing Articles' do
  # Defining scenario
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    @article1 = Article.create(title: 'The first article', body: 'Lorem Ipsum Dolor Sit', user: @john)
    @article2 = Article.create(title: 'The second article', body: 'Lorem Ipsum Dolor Sot', user: @john)
  end

  scenario 'A user lists all articles, user signed-in' do
    # Coming from Capybara -- conditions
    visit '/'
    login_as(@john)

    # Coming from Capybara -- expectations
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link('New Article')
  end

  scenario 'A user lists all articles user, not signed in' do
    # Coming from Capybara -- conditions
    visit '/'

    # Coming from Capybara -- expectations
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link('New article')
  end
end
