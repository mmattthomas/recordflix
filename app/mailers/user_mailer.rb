class UserMailer < ApplicationMailer
    default from: 'noreply@recordpool.herokuapp.com'
 
    def welcome_email
      @user = params[:user]
      @team = params[:team]
      @url  = 'http://recordpool.herokuapp.com/login'
      mail(to: @user.email, subject: 'Welcome to the recordpool!')
    end
end
