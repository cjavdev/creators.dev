class LoginLinksMailer < ApplicationMailer

  def login_link(customer, store)
    @customer = customer
    @store = store

    @customer.reset_session_token!
    mail(to: @customer.email, subject: 'Login Link')
  end
end
