module Stores
  class OrdersController < StoreBaseController
    before_action :authenticate_customer!

    def index
      @orders = current_customer.customer_products
    end

    def show
      @customer_product = CustomerProduct.find(params[:id])
      @product = @customer_product.product
    end
  end
end
