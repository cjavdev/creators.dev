class PayoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    @account_session = Stripe::AccountSession.create(
      {
        account: current_user.account.stripe_id,
      },
      {
        # stripe_account: current_user.account.stripe_id,
        stripe_version: "2020-08-27;embedded_connect_beta=v1"
      }
    )
  rescue => e
    flash[:error] = e.message
  end

  def create
    service = StripeAccount.new(current_user.account)
    service.payout

    redirect_to payouts_path
  end
end
