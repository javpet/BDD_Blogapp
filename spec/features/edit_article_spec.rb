require 'rails_helper'

RSpec.feature 'Editing Articles' do
  before do
    @article = Article.create(title: 'hohoohooo', body: 'also hohohohoho')
  end

  # Defining scenario
  scenario 'A user updates a new article' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link(@article.title)
    click_link('Edit Article')

    fill_in('Title', with: 'Updating a blog title')
    fill_in('Body', with: 'Updating Lorem Ipsum')
    click_button('Update Article')

    # Coming from Capybara -- expectations
    expect(page).to have_content('Article has been updated')
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'A user fails to update a new article' do
    # Coming from Capybara -- conditions
    visit '/'
    click_link(@article.title)
    click_link('Edit Article')

    fill_in('Title', with: '')
    fill_in('Body', with: 'Updating')
    click_button('Update Article')

    # Coming from Capybara -- expectations
    expect(page).to have_content('Article has not been updated')
    expect(page.current_path).to eq(article_path(@article))
  end
end
