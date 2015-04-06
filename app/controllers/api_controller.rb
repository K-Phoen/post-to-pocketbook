class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_article
    @article = Article.new(article_params)

    if @article.save
      PdfGenerationWorker.perform_async(@article.id)

      render json: @article, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private
  def article_params
    params.permit(:title, :url)
  end
end
