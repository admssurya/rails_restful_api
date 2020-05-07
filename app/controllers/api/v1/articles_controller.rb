class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.order('created_at DESC')

    render json: {
        status: 'SUCCESS',
        message: 'OK',
        payload: articles
    }, status: :ok
  end

  def show
    article = Article.find_by_id(params[:id])

    if article
      render json: {
          status: 'SUCCESS',
          message: 'OK',
          payload: article
      }, status: :ok
    else
      render json: {
          status: 'SUCCESS',
          message: 'Data not found',
          payload: Array.new
      }, status: :ok
    end
  end

  def create
    article = Article.new(article_params)

    if article.save
      render json: {
          status: 'SUCCESS',
          message: 'OK',
          payload: article
      }, status: :ok
    else
      render json: {
          status: 'ERROR',
          message: 'Data not saved',
          payload: article.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find(params[:id])

    if article.update_attributes(article_params)
      render json: {
          status: 'SUCCESS',
          message: 'OK',
          payload: article
      }, status: :ok
    else
      render json: {
          status: 'ERROR',
          message: 'Data not updated',
          payload: article.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find(params[:id])

    if article.destroy
      render json: {
          status: 'SUCCESS',
          message: 'OK',
          payload: article
      }, status: :ok
    else
      render json: {
          status: 'ERROR',
          message: 'Data not deleted',
          payload: article.errors
      }, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.permit(:title, :body)
  end
end
