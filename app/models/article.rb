class Article < ActiveRecord::Base
  validates :url, presence: true, format: { with: URI.regexp }
end
