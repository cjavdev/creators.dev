module Stores
  class LoginsController < StoreBaseController
    def index
      render plain: "Check your email."
    end

    def show
      @customer = current_store.customers.find_by(session_token: params[:id])
      if @customer
        session[:customer] = @customer.session_token
      end
      redirect_to orders_path
    end

    def new
    end

    def create
      customer = current_store.customers.find_by(email: params[:email])

      if customer
        LoginLinkMailer.send_link(customer, current_store).deliver_later
      end

      redirect_to logins_path
    end
  end
end
