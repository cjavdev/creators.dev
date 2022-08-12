class StripeCardholder
  attr_reader :params, :cardholder

  def initialize(params, cardholder)
    @params = params
    @cardholder = cardholder
  end

  def create_cardholder
    address_parms = params[:cardholder][:billing][:address]
    stripe_cardholder = Stripe::Issuing::Cardholder.create({
      type: 'individual',
      name: cardholder.name,
      email: cardholder.email,
      phone_number: '+18888675309',
      billing: {
        address: {
          line1: address_parms[:line1],
          city: address_parms[:city],
          state: address_parms[:state],
          country: address_parms[:country],
          postal_code: address_parms[:postal_code]
        },
      },
    }, {
      stripe_account: cardholder.account.stripe_id,
    })
    cardholder.update(
      stripe_id: stripe_cardholder.id,
      data: stripe_cardholder
    )
  end
end
