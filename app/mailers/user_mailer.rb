class UserMailer < ApplicationMailer
  default from: 'hello@creatorplatform.xyz'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Welcome to the creator platform"

    mail(to: "to@example.org", subject: "This is our subject")
  end
end
