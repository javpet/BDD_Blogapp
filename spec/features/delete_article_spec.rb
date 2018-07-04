require 'rails_helper'

RSpec.feature 'Deleting Articles' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    login_as(@john) # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
    @article = Article.create(title: 'hohoohooo', body: 'also hohohohoho', user: @john)
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
