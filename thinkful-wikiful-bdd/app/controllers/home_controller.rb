class HomeController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc).limit(10)
  end
end
