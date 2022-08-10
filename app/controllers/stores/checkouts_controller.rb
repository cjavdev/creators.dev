module Stores
  class CheckoutsController < StoreBaseController

    def show
      render plain: "Thanks"
    end

    def create
      checkout_session = Stripe::Checkout::Session.create({
        mode: 'payment',
        success_url: store_checkout_url,
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
