module Stores
  class StoreBaseController < ApplicationController
    layout 'stores'
    before_action :set_store
    before_action :current_customer

    def set_store
      @store ||= Store.find_by_request(request)
    end

    def authenticate_customer!
      if !current_customer
        redirect_to new_login_path
      end
    end

    def current_customer
      @customer ||= begin
        if params[:t]
          puts "Logging in user with qs param: #{params[:t]}"
          @customer = Customer.find_by(session_token: params[:t])
          session[:customer] = @customer.id if @customer
        end
        if session[:customer]
          puts "User logged in with session: #{session[:customer]}"
          @customer = Customer.find(session[:customer])
        end
      end
    end
  end
end
