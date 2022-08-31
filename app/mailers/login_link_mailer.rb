class LoginLinkMailer < ApplicationMailer
  default from: "hello@creatorplatform.xyz"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.login_link_mailer.send_link.subject
  #
  def send_link(customer, store)
    @customer = customer
    @store = store

    @customer.reset_session_token!

    mail to: @customer.email, subject: "Login Link"
  end
end
