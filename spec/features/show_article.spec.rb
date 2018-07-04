require 'rails_helper'

RSpec.feature 'Show an Article' do
  # Defining scenario
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    login_as(@john) # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
    @article = Article.create(title: 'The fourth article', body: 'Lorem Ipsumissimio', user: @john)
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
