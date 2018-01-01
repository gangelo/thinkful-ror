class ArticlesController < ApplicationController
  before_action :validate_user, only: [:new, :create]

  def index
    @articles = Article.order(created_at: :desc)
  end

  def show
    if params_id_valid? && Article.exists?(params[:id])
      @articles = Article.find(params[:id])
    else
      flash[:error] = 'That article id is invalid!'
      redirect_to articles_path
    end
  end

  def new
    @article = Article.new
  end

  def create
    #logger.info "article_params: #{article_params.to_yaml}"
    #logger.info "article_params[:category_ids]: #{article_params[:category_ids].to_yaml}"

    @article = current_user.articles.create(article_params)
    if @article.save
        redirect_to articles_path(@article) and return
    end
    render :new
  end

  def search
  end

  def author
    @articles = Article.find_by_author_name(author_params[:author])
    if @articles.nil? || @articles.count == 0
      flash[:notice] = 'No articles could be found for that author'
    end
    render :search
  end

  def date 
      @articles = Article.find_by_date_published(Date.parse(date_params[:date]))
      if @articles.nil? || @articles.count == 0
        flash[:notice] = 'No articles could be found for that publish date'
      end
      render :search
  end

  # Ajax helpers.
  def autocomplete_authors
    @authors = User.order(name: :asc).select(:id, 'name AS label').where("name like ?", "%#{params[:term]}%")
    respond_to do |format|
      format.json { render json: @authors.to_json }
    end
  end

  private

  def validate_user
    if !current_user?
      flash[:error] = 'You must be logged in to create an article'
      redirect_to(articles_path) and return
    end
  end

  def author_params
    params.permit(:author)
  end

  def date_params
    params.permit(:date)
  end

  def article_params
    params.require(:article).permit(:title, :content, category_ids: [])
  end
end
