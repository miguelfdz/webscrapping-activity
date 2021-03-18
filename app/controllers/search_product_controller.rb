require 'json'
require 'rest-client'

class SearchProductController < ApplicationController
  def new
    @search_product = SearchProduct.new()
    search = [params[:json]]
  end

  def create
    @search_product = SearchProduct.new(get_params(params[:search_product]))
    if @search_product.save
      json = SearchProducts::LinkResult.scrap(@search_product)
      redirect_to new_search_product_path(:json => json )
    end
  end

  private
  def get_params(params)
    {
      "product" => params[:product],
      "sort" => params[:sort],
      "quantity" => params[:quantity]
    }
  end
end
