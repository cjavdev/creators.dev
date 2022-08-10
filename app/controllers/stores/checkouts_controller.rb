module Stores
  class CheckoutsController < StoreBaseController

    def show
      @checkout_session = Stripe::Checkout::Session.retrieve({
        id: params[:session_id],
        expand: ['line_items.data.price.product', 'payment_intent.payment_method']
      }, {
        stripe_account: @store.user.account.stripe_id
      })
    end

    def create
      checkout_session = Stripe::Checkout::Session.create({
        mode: 'payment',
        success_url: store_checkout_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: store_root_url,
        line_items: [{
          price: params[:price],
          quantity: 1
        }]
      }, {
        stripe_account: @store.user.account.stripe_id
      })

      redirect_to checkout_session.url, allow_other_host: true, status: :see_other
    end
  end
end
