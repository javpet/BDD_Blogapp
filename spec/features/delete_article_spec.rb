require 'rails_helper'

RSpec.feature 'Deleting Articles' do
  before do
    @article = Article.create(title: 'hohoohooo', body: 'also hohohohoho')
  end

  # Defining scenario
  scenario 'A user deletes an article' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link(@article.title)
    click_link('Delete Article')

    # Coming from Capybara -- expectations
    expect(page).to have_content('Article has been deleted')
    expect(current_path).to eq(root_path)
  end
end
