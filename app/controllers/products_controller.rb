class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      service = StripeProduct.new(params, @product)
      service.create_product
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
  end

  private

  def product_params
    params.require(:product).permit(:name, :description)
  end
end
