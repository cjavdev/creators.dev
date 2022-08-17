class EphemeralKeysController < ApplicationController
  before_action :authenticate_user!

  def show
    # /cards/:card_id/ephemeral_key
    @card = current_user.cards.find(params[:card_id])
    @ephameral_key = Stripe::EphemeralKey.create({
      issuing_card: @card.stripe_id,
      nonce: params[:nonce],
    }, {
      stripe_account: current_user.account.stripe_id,
      stripe_version: params[:version]
    })
    render json: @ephameral_key
  end
end
