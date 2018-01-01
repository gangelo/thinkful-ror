class WelcomeController < ApplicationController

  def index
    @page_header = plural_page_title(Article)
  	@articles = Article.order(created_at: :desc).limit(5)
  end
end
