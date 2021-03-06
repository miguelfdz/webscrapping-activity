class SearchProductController < ApplicationController
  def new
    @search_product = SearchProduct.new() 
  end

  def create
    @search_product = SearchProduct.new(params[:search_product])
    if @search_product.save
      redirect_to new_search_product_path
    end
  end
end
