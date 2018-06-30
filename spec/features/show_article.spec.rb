require 'rails_helper'

RSpec.feature 'Show an Article' do
  # Defining scenario
  before do
    @article = Article.create(title: 'The fourth article', body: 'Lorem Ipsumissimio')
  end

  scenario 'A user shows a new article' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link(@article.title)

    # Coming from Capybara -- expectations
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
