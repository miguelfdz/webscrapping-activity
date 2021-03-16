class SearchProductController < ApplicationController
  def new
    @search_product = SearchProduct.new() 
  end

  def create
    link = SearchProducts::LinkResult.generate_link(params[:search_product])
    add_link_to_txt_file(link)
    sleep(5)
    SearchProducts::LinkResult.scrap
    sadjhkjh
    redirect_to show_search_product_path
  end

  private

  def add_link_to_txt_file(link)
    file = File.open('pcel_link.txt', 'w') { |f|
      f.write "#{link}"
    }
  end
end
