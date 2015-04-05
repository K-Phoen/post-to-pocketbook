class AddPdfToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :pdf, :string
  end
end
