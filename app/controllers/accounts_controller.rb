class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account_session, only: [:index]

  def index

  end

  def create
    @account = Account.find_or_create_by(user: current_user)
    service = StripeAccount.new(@account)
    service.create_account
    redirect_to service.onboarding_url, allow_other_host: true, status: :see_other
  end

  def set_account_session
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
end
