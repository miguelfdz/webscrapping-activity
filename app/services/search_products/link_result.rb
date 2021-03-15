require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'kimurai'
end

require 'kimurai'

module SearchProducts
  module LinkResult

    def self.build_link(params)
      $link = Builder.new(params).link_with_params;
    end

    def self.scrap_link
      PcelScrapper.crawl!
    end

    class Builder
      TRANSLATE = {"Ascendiente" => "ASC", "Descendiente" => "DESC"}

      attr_reader :product, :quantity, :sort

      def initialize(params)
        @product = params[:product]
        @quantity = params[:quantity]
        @sort = params[:sort]
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

    class PcelScrapper < Kimurai::Base
      attr_accessor :link

      puts $link
      @name = 'slack_spider'
      @engine = :mechanize
      @start_urls = [$link]

      def parse(response, url:, data: {})
        @base_uri = 'https://pcel.com'
        response = browser.current_response

        response.css('tr').each do |row|
          scraped_pcel_products(row)
        end
      end

      private

      def scraped_pcel_products(row)
        item = {}
        item[:name] = row.css('div.name a').text
        item[:product_link] = row.css('div.name a').attr('href')
        item[:price] = row.css('div.price').text
        item[:image] = row.css('div.image img')

        if item[:product_link] != nil
          save_to "scraped_pcel_products.json", item, format: :pretty_json, position: false
        end
      end
    end
  end
end