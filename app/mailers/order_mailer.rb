class OrderMailer < ApplicationMailer
  default from: 'hello@creatorplatform.xyz'

  def new_order(customer_product)
    @customer_product = customer_product
    @product = customer_product.product
    @customer = customer_product.customer

    @customer.reset_session_token!

    mail to: @customer.email, subject: "New Order - #{@product.name}"
  end
end
