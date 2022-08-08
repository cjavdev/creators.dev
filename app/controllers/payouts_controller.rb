class PayoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    service = StripeAccount.new(current_user.account)
    service.payout

    redirect_to dashboard_path
  end
end
