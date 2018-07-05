class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created' # .now displays it only once the error
      render new_article_path
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
    @comment = @article.comments.build
  end

  def edit
    unless @article.user == current_user
      flash[:danger] = 'You can only edit your own article!'
      redirect_to root_path
    end
  end

  def update
    if @article.user == current_user
      if @article.update(article_params)
        flash[:success] = 'Article has been updated'
        redirect_to article_path(@article)
      else
        flash[:danger] = 'Article has not been updated'
        render :edit
      end
    else
      flash[:danger] = 'You can only edit your own article!'
      redirect_to root_path
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:success] = 'Article has been deleted'
      redirect_to root_path
    end
  end

  protected

  def resource_not_found
    message = 'The article you are looking for could not be found'
    flash[:alert] = message
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
