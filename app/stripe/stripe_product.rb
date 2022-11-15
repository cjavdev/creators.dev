class StripeProduct
  attr_reader :params, :product

  def initialize(params, product)
    @params = params
    @product = product
  end

  def currency_options
    params
      .fetch(:currency_options, [])
      .inject({}) do |acc, option|
        acc[option[:currency]] = {unit_amount: (option[:amount].to_f * 100).to_i}
        acc
      end
  end

  def create_product
    return if product.stripe_id.present?
    images = []

    if product.photo && product.photo.representation(:medium)
      images << product.photo.representation(:medium).processed.url
    end

    stripe_product = Stripe::Product.create({
      name: product.name,
      description: product.description,
      images: images,
      metadata: {
        user_id: product.user_id,
        product_id: product.id
      },
      default_price_data: {
        currency: params[:default_price_data][:currency],
        unit_amount: (params[:default_price_data][:amount].to_f * 100).to_i,
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
