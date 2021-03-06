class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      PdfGenerationWorker.perform_async(@article.id)

      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    article = Article.find(params[:id])

    if not article.pdf.nil?
      File.delete('public/pdf/' + article.pdf)
    end

    article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :url)
  end
end
