class OrderMailer < ApplicationMailer
  default from: 'hello@creatorplatform.xyz'

  def confirmed(customer_product)
    @customer_product = customer_product
    @customer = customer_product.customer
    @product = customer_product.product

    mail(
      to: @customer.email,
      subject: "Order Confirmed: #{@product.name}"
    )
  end
end
