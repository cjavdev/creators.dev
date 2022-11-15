class CheckoutsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    account = product.user.account

    checkout_session = Stripe::Checkout::Session.create({
      customer_email: "test+location_FR@example.com",
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
      line_items: [{
        price: product.stripe_price_id,
        quantity: 1,
      }],
      payment_intent_data: {
        application_fee_amount: 200,
        description: product.description,
        metadata: {
          name: product.name,
        }
      },
    }, {
      stripe_account: account.stripe_id,
    })

    redirect_to checkout_session.url, allow_other_host: true, status: :see_other
  end
end
