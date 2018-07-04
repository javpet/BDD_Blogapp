require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    @fred = User.create!(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'Hollllaaa', body: 'Lorem is the best', user: @john)
  end

  describe 'GET/articles/:id/edit' do
    context 'with non-signed in user' do
      before do
        get "/articles/#{@article.id}/edit"
      end

      it 'redirect to the sign in page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end

      it 'redirect to the home page' do
        expect(response.status).to eq 302
        flash_message = 'You can only edit your own article!'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who as owner' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
      end

      it 'successfully edit article' do
        expect(response.status).to eq 200
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@fred)
        delete "/articles/#{@article.id}/"
      end

      it 'redirect to the home page' do
        expect(response.status).to eq 302
        flash_message = 'You can only delete your own article!'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with non-signed in user' do
      before do
        delete "/articles/#{@article.id}/"
      end

      it 'redirect to the sign in page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing'
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user who as owner' do
      before do
        login_as(@john)
        delete "/articles/#{@article.id}"
      end

      it 'successfully edit article' do
        expect(response.status).to eq 200
      end
    end
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
