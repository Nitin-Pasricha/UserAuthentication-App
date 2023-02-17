class NotifierMailer < ApplicationMailer
    default from: 'notifier@example.com'
    
    def welcome_email
        @user = params[:user]
        @url = "http://localhost:3000/login"
        mail(to: @user.email, subject: "Welcome to CodeSprint")
    end

    def reset_password_notification
        @user = params[:user]
        @url = "http://localhost:3000/login"
        mail(to: @user.email, subject: "CodeSprint: Password reset successful")
    end
end
