class StripeCard
  attr_reader :card, :params

  def initialize(params, card)
    @params = params
    @card = card
  end

  def create_card
    # TODO: create physical cards that can be mailed.

    stripe_card = Stripe::Issuing::Card.create({
      cardholder: card.cardholder.stripe_id,
      currency: 'usd',
      type: 'virtual',
      financial_account: card.cardholder.account.financial_account_id,
    }, {
      stripe_account: card.cardholder.account.stripe_id,
    })

    card.update(
      stripe_id: stripe_card.id,
      data: stripe_card,
      last4: stripe_card.last4,
    )
  end
end
