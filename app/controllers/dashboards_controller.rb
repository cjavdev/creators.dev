class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    if !current_user.account.nil?
      @financial_balances = StripeAccount.new(current_user.account).financial_balances
      @payments_balances = StripeAccount.new(current_user.account).payments_balances
    end
  end
end
