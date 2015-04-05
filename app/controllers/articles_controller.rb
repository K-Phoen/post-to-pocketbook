require 'open-uri'

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.valid?
      source = open(@article.url).read
      document = Readability::Document.new(source)

      if @article.title.empty?
        @article.title = (document.title.empty? && @article.url) || document.title
      end

      @article.content = document.content

      pdf = generate_pdf(@article)

      ArticleMailer.share_with_pocketbook_email(@article, pdf).deliver_now
    end

    if @article.save
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :url)
  end

  def generate_pdf(article)
    article.pdf = article.title.parameterize << '.pdf'
    path = 'public/pdf/' << article.pdf

    kit = PDFKit.new(article.url)
    kit.to_file(path)

    path
  end
end
