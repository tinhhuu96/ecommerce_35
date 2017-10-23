class UserNotifierMailer < ApplicationMailer
  def send_order_email user, cart
    @user = user
    @cart = cart
    mail to: @user.email,
    subject: t("thanks_mailer")
  end

  def send_mail_status email, order
    @user = User.find_by email: email
    @cart = order
    mail to: @user.email,
    subject: t("thanks_mailer")
  end
end
