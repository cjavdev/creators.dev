class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account_session

  def index

  end

  def show
  end

  private

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
