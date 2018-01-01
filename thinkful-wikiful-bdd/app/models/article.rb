class Article < ActiveRecord::Base
  belongs_to :user

  has_many :article_categories
  has_many :categories, through: :article_categories

  validates_length_of :title , minimum: 3, maximum: 128
  validates_length_of :content, minimum: 3, maximum: 64000

  #validates_presence_of :user
  validates_presence_of :categories

  def self.find_by_author_id(id)
    Article.order(created_at: :desc).where(user_id: id)
  end

  def self.find_by_author_user_name(user_name)
    user = User.where('lower(user_name) = ?', user_name.downcase).first
    return [] if user.nil?
    user.articles
  end

  def self.find_by_author_name(name)
    user = User.where('lower(name) = ?', name.downcase).first
    return [] if user.nil?
    user.articles
  end

  def self.find_by_date_published(date_published)
    Article.where('extract(month from created_at) = ? AND extract(day from created_at) = ? AND extract(year from created_at) = ?', 
      date_published.month, date_published.day, date_published.year)
  end
end