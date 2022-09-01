module Stores
  class OrdersController < StoreBaseController
    before_action :authenticate_customer!

    def index
      @orders = current_customer.customer_products.order(created_at: :desc)
    end

    def show
      @order = current_customer.customer_products.find(params[:id])
      @product = @order.product
    end
  end
end
