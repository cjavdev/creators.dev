class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    case event.source
    when 'stripe'
      handle_stripe_event(event)
    end
  end

  def handle_stripe_event(event)
    stripe_event = Stripe::Event.construct_from(event.data)
    case stripe_event.type
    when 'account.updated'
      handle_account_updated(stripe_event)
    when 'capability.updated'
      handle_capability_updated(stripe_event)
    when 'customer.created'
      handle_customer_created(stripe_event)
    when 'checkout.session.completed'
      handle_checkout_session_completed(stripe_event)
    when 'checkout.session.async_payment_succeeded'
      handle_checkout_session_completed(stripe_event)
    when 'treasury.financial_account.features_status_updated'
      handle_financial_account_features_status_updated(stripe_event)
    end
  end

  def handle_checkout_session_completed(stripe_event)
    session = Stripe::Checkout::Session.retrieve({
      id: stripe_event.data.object.id,
      expand: ['line_items'],
    }, {
      stripe_account: stripe_event.account,
    })

    return if session.payment_status != 'paid'

    product = Product.find_by(stripe_id: session.line_items.data[0].price.product)
    customer = Customer.find_or_initialize_by(
      stripe_id: session.customer,
      store: product.store
    )
    customer.email = session.customer_details.email
    customer.save!

    customer_product = CustomerProduct.create!(
      customer: customer,
      product: product,
      checkout_session_id: session.id,
    )
    OrderMailer.new_order(customer_product).deliver_later
  end

  def handle_financial_account_features_status_updated(stripe_event)
    financial_account = stripe_event.data.object
    if financial_account.active_features.include?('financial_addresses.aba')
      account = Account.find_by(stripe_id: stripe_event.account)
      service = StripeAccount.new(account)
      service.ensure_external_account
    end
  end

  def handle_capability_updated(stripe_event)
    capability = stripe_event.data.object
    if capability.id == 'treasury' && capability.status == 'active'
      # Create a financial account for the connected account
      account = Account.find_by(stripe_id: capability.account)
      service = StripeAccount.new(account)
      service.ensure_financial_account
    end
  end

  def handle_account_updated(stripe_event)
    stripe_account = stripe_event.data.object
    account = Account.find_by(stripe_id: stripe_account.id)
    account.update(
      charges_enabled: stripe_account.charges_enabled,
      payouts_enabled: stripe_account.payouts_enabled,
    )
  end

  def handle_customer_created(stripe_event)
    puts "customer.created #{stripe_event.data.object.id}"
  end
end

