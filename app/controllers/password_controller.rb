class PasswordController < ApplicationController

  def forgot_password
    if(request.post?)
      @user = User.find_by_email(params[:email])
      if @user
        params[:new_password] = generate_random_password
        update_password
      else
        flash[:error] = "Invalid email. User doesn't exist."
        render :forgot_password
      end
    end
  end

  def generate_random_password
    (0...8).map { (65 + rand(26)).chr }.join
  end

  # common method for forgot_password and reset_password
  def update_password
    @user.update(:pswd=>params[:new_password])
    if session[:user]
      NotifierMailer.with(user:@user).reset_password_notification.deliver
    else
      NotifierMailer.with(user:@user).temp_password_notification.deliver
    end
    redirect_to logout_url
  end

  def reset_password
    if(!session[:user])
      redirect_to login_url
    end
    if(request.post?)
      if(params[:new_password]!= params[:new_password_confirmation])
        flash[:error] = "New password confirmation don't match."
        render :reset_password
        return
      end
      @user = User.find(session[:user])
      @returned_user = User.authenticate(@user.email, params[:pswd])
      if(@user==@returned_user)
        update_password
      else
        flash[:error] = "Current password don't match."
        render :reset_password
      end
    end
  end

end
