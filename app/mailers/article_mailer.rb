class ArticleMailer < ApplicationMailer
  default to: 'kevin@pbsync.com'
  default from: 'contact+pbsync@kevingomez.fr'

  def share_with_pocketbook_email(article, file)
    attachments[File.basename(file)] = File.read(file)

    mail(to: Rails.application.secrets.share_email, subject: 'Article shared') do |format|
      format.text { render text: 'New article shared.' }
    end
  end
end
