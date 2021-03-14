module SearchProduct
  module LinkResult
    
    def self.build_link(params)
      builder = Builder.new(params)
    end

    class Builder

      attr_reader: :product, :quantity, :sort

      def initializer(params)
        @product = params[:product]
        @quantity = params[:quantity]
        @sort = params[:sort]
      end

      private

      def pcel_link
        "https://pcel.com/index.php?route=product/search&filter_name="
      end
    end
  end
end