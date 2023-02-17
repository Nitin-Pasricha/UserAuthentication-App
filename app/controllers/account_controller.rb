class AccountController < ApplicationController

    def create_account
        @user = User.new
        if request.post?
            @user = User.new(set_params)
            if @user.save
                NotifierMailer.with(user: @user).welcome_email.deliver_later
                redirect_to :login
            else
                render :create_account
            end
        end
    end

    def login
        if request.post?
            @user = User.authenticate(params[:email], params[:pswd])
            if @user
                session[:user] = @user.id
                redirect_to dashboard_path(@user)
            else
                flash.now[:error] = "Invalid email or password."
                render :login
            end
        end
    end

    def dashboard
        if(!session[:user])
            render :login
            return
        end
        if(session[:user]!=params[:id])
            params[:id]=session[:user]
        end
        @user = User.find(params[:id])
    end


    def logout
        session.delete(:user)
        redirect_to :login
    end
    
    private
    def set_params
        params.permit(:first_name, :last_name, :email, :pswd, :pswd_confirmation, :password, :contact_no, :dob)
    end
end
