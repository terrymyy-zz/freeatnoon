class UserMailer < Devise::Mailer
  def send_time_input_reminder(user)
    @user = user
    mail(to: @user.email, subject: "F@N - Tell us when you are free!")
  end
end
