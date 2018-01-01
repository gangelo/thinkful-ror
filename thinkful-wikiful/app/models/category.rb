class Category < ActiveRecord::Base
	belongs_to :label_color

	has_many :article_categories
	has_many :articles, through: :article_categories

	validates_uniqueness_of :name
end
