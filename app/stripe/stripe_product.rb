class StripeProduct
  attr_reader :params, :product

  def initialize(params, product)
    @params = params
    @product = product
  end

  def create_product
    return if product.stripe_id.present?

    currency_options = params[:currency_options].inject({}) do |acc, option|
      acc[option[:currency]] = {
        unit_amount: option[:amount],
      }
      acc
    end

    stripe_product = Stripe::Product.create({
      name: product.name,
      description: product.description,
      metadata: {
        user_id: product.user_id,
        product_id: product.id
      },
      default_price_data: {
        currency: params[:default_price_data][:currency],
        unit_amount: params[:default_price_data][:amount],
        currency_options: currency_options
      },
      expand: ['default_price'],
    }, {
      stripe_account: product.user.account.stripe_id
    })

    product.update(
      stripe_id: stripe_product.id,
      data: stripe_product.to_json,
      stripe_price_id: stripe_product.default_price.id,
    )
  end
end
