class ArticleCategory < ActiveRecord::Base
  attr_accessor :article_id, :category_id

  belongs_to :article 
  belongs_to :category
end
