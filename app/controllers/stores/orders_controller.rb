module Stores
  class OrdersController < StoreBaseController
    before_action :authenticate_customer!

    def index
      render plain: "ye"
    end
  end
end
