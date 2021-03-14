require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'kimurai'
end

require 'kimurai'

# PcelScrapper
class PcelScrapper < Kimurai::Base
  @name = 'slack_spider'
  @engine = :mechanize
  @start_urls = ['https://pcel.com/index.php?route=product/search&filter_name=alienware&sort=p.price&order=DESC&limit=5']

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

PcelScrapper.crawl!