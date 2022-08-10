module Stores
  class ProductsController < StoreBaseController
    def index
      @products = @store.products
    end

    def show
      @product = @store.products.find(params[:id])
    end
  end
end
