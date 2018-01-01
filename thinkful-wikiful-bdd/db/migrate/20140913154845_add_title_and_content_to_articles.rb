class AddTitleAndContentToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :title, :string, limit: 64
    add_column :articles, :content, :text, limit: 64000
  end
end
