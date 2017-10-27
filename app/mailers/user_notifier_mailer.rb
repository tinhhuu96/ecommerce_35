class UserNotifierMailer < ApplicationMailer
  def send_order_email user, cart
    @user = user
    @cart = cart
    mail to: @user.email,
    subject: t("thanks_mailer")
  end
end
