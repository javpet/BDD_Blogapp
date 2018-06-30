require 'rails_helper'

RSpec.feature 'Listing Articles' do
  # Defining scenario
  before do
    @article1 = Article.create(title: 'The first article', body: 'Lorem Ipsum Dolor Sit')
    @article2 = Article.create(title: 'The second article', body: 'Lorem Ipsum Dolor Sot')
  end

  scenario 'A user lists all articles' do
    # Coming from Capybara -- conditions
    visit '/'

    # Coming from Capybara -- expectations
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
end
