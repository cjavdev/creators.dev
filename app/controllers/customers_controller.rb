class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = current_user.store.customers.all
  end

  def show
    @customer = current_user.store.customers.find(params[:id])
  end
end
