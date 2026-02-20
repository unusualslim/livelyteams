class UserMailer < ApplicationMailer
  default from: 'no-reply@livelyteams.com'

  def welcome_email(user)
    @user = user
    @url = "#{ENV['HOSTNAME']}/login"
    mail(to: @user.email, subject: "Welcome to #{ENV['HOSTNAME']}")
  end
end