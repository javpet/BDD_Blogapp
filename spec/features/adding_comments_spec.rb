require 'rails_helper'

RSpec.feature 'Adding reviews to articles' do
  # Defining scenario
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    @fred = User.create!(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'The fourth article', body: 'Lorem Ipsumissimio', user: @john)
  end

  scenario 'Permits a signed-in user to write a review' do
    login_as(@fred)

    visit '/'
    click_link(@article.title)

    fill_in('New Comment', with: 'An amazing airtcle')
    click_button('Add Comment')
    expect(page).to have_content('Comment has been created')
    expect(current_path).to eq(article_path(@article.id))
  end
end
