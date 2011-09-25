class UserMailer < ActionMailer::Base
  default from: "sharemyfare@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/confirmation"
    mail(:to =>  user.email, :subject => "Welcome to Share My Fare")
  end
end
