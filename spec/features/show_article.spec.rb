require 'rails_helper'

RSpec.feature 'Show an Article' do
  # Defining scenario
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    @fred = User.create!(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'The fourth article', body: 'Lorem Ipsumissimio', user: @john)
  end

  scenario 'To non-signed in user hide the edit and delete' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link(@article.title)

    # Coming from Capybara -- expectations
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
    expect(current_path).to eq(article_path(@article))
  end

  scenario 'To a non-owner user hide the edit and delete' do
    # Coming from Capybara -- conditions
    login_as(@fred)
    visit '/'
    click_link(@article.title)

    # Coming from Capybara -- expectations
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
    expect(current_path).to eq(article_path(@article))
  end

  scenario 'To the signed-in owner show the edit and delete' do
    # Coming from Capybara -- conditions
    login_as(@john)
    visit '/'
    click_link(@article.title)

    # Coming from Capybara -- expectations
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).to have_link('Edit Article')
    expect(page).to have_link('Delete Article')
    expect(current_path).to eq(article_path(@article))
  end
end
