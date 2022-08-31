module Stores
  class StoreBaseController < ApplicationController
    layout 'stores'
    before_action :current_store

    def current_store
      @store ||= Store.find_by_request(request)
    end

    def authenticate_customer!
      if current_customer.nil?
        redirect_to new_login_path
      end
    end

    def current_customer
      @current_customer ||= Customer.where(
        session_token: session[:customer],
        token_expires_at: Time.now..
      ).first
    end
  end
end
