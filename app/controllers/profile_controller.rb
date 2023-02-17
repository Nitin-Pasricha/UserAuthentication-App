class ProfileController < ApplicationController
  def edit_profile
    if(!session[:user])
      redirect_to :login
    else
      @user = User.find(session[:user])
      if request.post?
        if @user.update(edit_params)
          redirect_to dashboard_path(@user)
        else
          puts @user.errors.full_messages
          render :edit_profile
        end
      end
    end
  end

  private
    def edit_params
      params.permit(:first_name, :last_name, :dob, :contact_no, :profile_pic)
    end
end
