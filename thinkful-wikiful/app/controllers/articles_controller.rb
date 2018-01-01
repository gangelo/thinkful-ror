
class ArticlesController < ApplicationController
	before_filter :authorize, only: [:new]
	
	def index
		@page_header = plural_page_title(Article)
		@articles = Article.order(updated_at: :desc).limit(25)
	end

	def show
		if params_id_valid?
			@page_header = singular_page_title(Article)
			@article = Article.find(params[:id])
		else
			redirect_to articles_path # :flash => { :error => "Insufficient rights!" } # For later
		end
	end

	def new
		@page_header = singular_page_title(Article)
	  @article = Article.new
	end

	def create
	  @article = Article.new(article_params)
	  if @article.save
	    redirect_to @article # show
	  else
	    render :new
	  end
	end

	private

	  def article_params
	    params.require(:article).permit(:title, :content, category_ids: [])
	  end
end
