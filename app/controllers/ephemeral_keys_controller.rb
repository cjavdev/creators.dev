class EphemeralKeysController < ApplicationController
  before_action :authenticate_user!

  def show
    @card = current_user.cards.find(params[:card_id])
    @ephemeral_key = Stripe::EphemeralKey.create({
      nonce: params[:nonce],
      issuing_card: @card.stripe_id,
    }, {
      stripe_account: current_user.account.stripe_id,
      stripe_version: params[:version],
    })
    render json: @ephemeral_key
  end
end
