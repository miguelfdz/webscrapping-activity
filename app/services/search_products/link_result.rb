require_relative('../pcel_scrapper.rb')

module SearchProducts
  module LinkResult

    def self.generate_link(url_params)
      url = Builder.new(url_params)
      url.link_with_params
    end

    def self.scrap
      PcelScrapper.crawl!
    end

    class Builder
      TRANSLATE = {"Ascendiente" => "ASC", "Descendiente" => "DESC"}

      attr_reader :product, :quantity, :sort

      def initialize(url_params)
        @product = url_params[:product]
        @quantity = url_params[:quantity]
        @sort = url_params[:sort]
      end

      def link_with_params
        "#{pcel_link}#{product_present_convertion}#{sort_present_convertion}#{quantity_present_convertion}"
      end

      private

      def pcel_link
        "https://pcel.com/index.php?route=product/search"
      end

      def product_to_link
        product = self.product.gsub(" ", "%20")
        "&filter_name=#{product}"
      end

      def sort_to_link
        "&sort=p.price&order=#{sort_translation}"
      end

      def quantity_to_link
        "&limit=#{quantity}"
      end

      def sort_translation
        TRANSLATE[self.sort]
      end

      def product_present_convertion
        has_product? ? product_to_link : ""
      end

      def quantity_present_convertion
        has_quantity? ? quantity_to_link : ""
      end

      def sort_present_convertion
        has_sort? ? sort_to_link : ""
      end

      def has_product?
        self.product.present?
      end

      def has_quantity?
        self.quantity.present?
      end

      def has_sort?
        self.sort.present?
      end
    end
  end
end