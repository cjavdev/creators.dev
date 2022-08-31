module Stores
  class LoginsController < StoreBaseController
    def index
      render plain: "Check your email."
    end

    def new
    end

    def create
      @customer = @store.customers.find_by(email: params[:email])
      if @customer
        LoginLinksMailer.login_link(@customer, @store).deliver_later
      end

      redirect_to logins_path
    end
  end
end
