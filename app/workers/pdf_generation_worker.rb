require 'open-uri'

class PdfGenerationWorker
  include Sidekiq::Worker

  def perform(article_id)
    article = Article.find(article_id)
    document = analyze_url(article.url)

    update_title(article, document)
    update_content(article, document)

    pdf = generate_pdf(article)

    article.save

    ArticleMailer.share_with_pocketbook_email(article, pdf).deliver_now
  end

  private
  def analyze_url(url)
    source = open(url).read

    Readability::Document.new(source)
  end

  def generate_pdf(article)
    article.pdf = article.title.parameterize << '.pdf'
    path = 'public/pdf/' << article.pdf

    kit = PDFKit.new(article.url)
    kit.to_file(path)

    path
  end

  def update_title(article, document)
    if article.title.empty?
      article.title = (document.title.empty? && article.url) || document.title
    end
  end

  def update_content(article, document)
    article.content = document.content
  end
end
