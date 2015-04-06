class Article < ActiveRecord::Base
  after_initialize :init

  validates :url, presence: true, format: { with: URI.regexp }

  def init
    self.title   ||= ""
    self.content ||= ""
  end
end
