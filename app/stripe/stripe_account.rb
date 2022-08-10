class StripeAccount
  include Rails.application.routes.url_helpers
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  def financial_balances
    financial_account.balance
  end

  def payments_balances
    @payments_balances ||= Stripe::Balance.retrieve(header)
  end

  def payout
    amount = payments_balances.available.first.amount
    @payout ||= Stripe::Payout.create({
      amount: amount,
      currency: 'usd',
    }, header)
  end

  def update_account_branding
    store = account.store
    return if store.primary_color.nil? || store.secondary_color.nil?
    Stripe::Account.update(account.stripe_id, {
      settings: {
        branding: {
          primary_color: store.primary_color,
          secondary_color: store.secondary_color,
        },
      }
    }, header)
  end

  def create_account
    return if account.stripe_id.present?

    stripe_account = Stripe::Account.create(
      type: 'custom',
      country: 'US',
      email: account.user.email,
      business_type: 'individual',
      individual: {
        email: account.user.email,
      },
      business_profile: {
        product_description: 'Digital creations and content',
        mcc: "5818",
        support_email: account.user.email,
        url: 'https://cjav.dev',
      },
      capabilities: {
        card_payments: { requested: true },
        transfers: { requested: true },
        # Requested capabilities
        treasury: { requested: true },
        card_issuing: { requested: true },
      },
    )

    account.update(stripe_id: stripe_account.id)
  end

  def ensure_external_account
    return if !account.external_account_id.nil?
    # Fetch the financial account
    account_info = financial_account.financial_addresses.first.aba
    # Use the aba addresses on the financial account to create an external account
    bank_account = Stripe::Account.create_external_account(
      account.stripe_id,
      {
        external_account: {
          object: 'bank_account',
          account_number: account_info.account_number,
          routing_number: account_info.routing_number,
          country: 'US',
          currency: 'usd',
        },
        default_for_currency: true,
      }
    )
    account.update(external_account_id: bank_account.id)
  end

  def financial_account
    @financial_account ||= Stripe::Treasury::FinancialAccount.retrieve({
      id: account.financial_account_id,
      expand: ['financial_addresses.aba.account_number'],
    }, header)
  end

  def ensure_financial_account
    return if !account.financial_account_id.nil?

    financial_account = Stripe::Treasury::FinancialAccount.create({
      supported_currencies: ['usd'],
      features: {
        card_issuing: { requested: true },
        deposit_insurance: { requested: true },
        financial_addresses: { aba: { requested: true } },
        inbound_transfers: { ach: { requested: true } },
        intra_stripe_flows: { requested: true },
        outbound_payments: {
          ach: { requested: true },
          us_domestic_wire: { requested: true },
        },
        outbound_transfers: {
          ach: { requested: true },
          us_domestic_wire: { requested: true },
        }
      },
    }, header)

    account.update(financial_account_id: financial_account.id)
  end

  def onboarding_url
    Stripe::AccountLink.create({
      account: account.stripe_id,
      refresh_url: accounts_url,
      return_url: accounts_url,
      type: 'account_onboarding',
      collect: 'eventually_due',
    }).url
  end

  def header
    { stripe_account: account.stripe_id }
  end
end
