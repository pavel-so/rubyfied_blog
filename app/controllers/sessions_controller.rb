class SessionsController < ApplicationController
  layout 'sign'
  before_filter :require_login, :except=>[:new, :forgot, :reset]

  # TODO make something more clear and convenient
  def new
    return unless params[:session]
    cred=params[:session]
    user=User.find_by_credentials(cred[:email], cred[:password])
    if user and user.active?
      session[:user_id]=user.id
      redirect_to root_path, :notice => 'Logged in'
    else
      flash[:error]= "Wrong email or password"
    end

  end

  def destroy
    session[:user_id]=nil
    redirect_to root_path, :notice => 'Logged out'
  end

  def forgot
    if params[:user]
      email = params[:user][:email]
      user  = User.where(:email=>email).first
      if user
        if user.send_reset_code
          flash[:notice]="Password reset token was sent to #{email}"
        else
          flash[:error] = "Error occurred during reset procedure. Please contact administrator."
        end
      else
        flash[:error]='User with such email is not registered in the system.'
      end
    end
  end

  def reset
    if params[:uid] && params[:reset_token]
      reset_token= params[:reset_token]
      user       = User.find(params[:uid])
      if user && reset_token==user.reset_code
        @user=user
        if params[:user]
          if @user.update_attributes(params[:user])
            Notification.was_reset_email(@user).deliver
            redirect_to(login_path, :notice => 'Password was successfully reset.') and return
          end
        end
      else
        flash[:error]="Your reset token is invalid."
      end
    end
  end
end

