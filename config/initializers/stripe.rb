Stripe.api_key = Rails.application.credentials.stripe[:secret]

module Stripe
  class AccountSession < APIResource
    extend Stripe::APIOperations::Create
    # extend Stripe::APIOperations::List
    # extend Stripe::APIOperations::Search
    # include Stripe::APIOperations::Save

    OBJECT_NAME = "account_session"
  end
end
