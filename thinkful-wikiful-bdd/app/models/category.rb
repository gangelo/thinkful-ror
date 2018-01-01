class Category < ActiveRecord::Base

  has_many :article_categories
  has_many :articles, through: :article_categories

  validates_length_of :name, minimum: 3, maximum: 16
end
