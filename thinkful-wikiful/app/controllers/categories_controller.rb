class CategoriesController < ApplicationController
  def index
    @page_header = plural_page_title(Category)
  end

  def show
  	if params_id_valid?
      @page_header = plural_page_title(Category)
		  @category = Category.find(params[:id])
  	else
  		redirect_to categories_path # :flash => { :error => "Insufficient rights!" } # For later
  	end
  end
end
