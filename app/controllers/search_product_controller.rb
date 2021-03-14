class SearchProductController < ApplicationController
  def new
    @search_product = SearchProduct.new() 
  end

  def create
    link = SearchProducts::LinkResult.build_link(params[:search_product])
    oishdihsa
    if @search_product.save
      redirect_to new_search_product_path
    end
  end
end
