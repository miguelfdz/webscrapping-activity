class SearchProductController < ApplicationController
  def new
    @search_product = SearchProduct.new() 
  end

  def create
    @search_product = SearchProduct.new(get_params(params[:search_product]))
    if @search_product.save
      add_link_to_txt_file(link)
      SearchProducts::LinkResult.scrap
      redirect_to show_search_product_path
    end
  end

  private
  def get_params(params)
    {
      "product" => params[:product],
      "sort" => params[:sort],
      "quantity" => params[:quantity],
      "link" => SearchProducts::LinkResult.generate_link(params)
    }
  end

  def add_link_to_txt_file(link)
    file = File.open('pcel_link.txt', 'w') { |f|
      f.write "#{link}"
    }
  end
end
