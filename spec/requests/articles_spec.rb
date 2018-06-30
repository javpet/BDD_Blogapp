require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    @article = Article.create(title: 'Hollllaaa', body: 'Lorem is the best')
  end

  describe 'GET/articles/:id' do
    context 'with existing article' do
      before do
        get "/articles/#{@article.id}"
      end

      it 'handles existig article' do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before do
        get '/articles/xxxx'
      end

      it 'handles non-existig article' do
        expect(response.status).to eq 302
        flash_message = 'The article you are looking for could not be found'
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end
