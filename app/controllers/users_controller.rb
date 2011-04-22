class UsersController < ApplicationController
  before_filter :require_login, :except=>%w'new create activate'
  layout :choose_layout
  respond_to :html

  def index
    @users=User.all
    respond_with(@users)
  end

  def show
    @user=User.find(params[:id])
    respond_with(@user)
  end

  def edit
    @user=User.find(params[:id])
    respond_with(@user)
  end

  def create
    if logged_in? or !(User.count>0)
      @user=User.new(params[:user])
      if @user.save
        redirect_to @user,:notice=>"User was successfully created"
      else
        render :action=>'new'
      end
    else
      redirect_to login_path, :notice=>"Registration is closed."
    end
  end

  def new
    if logged_in? or !(User.count>0)
      @user=User.new
      respond_with(@user)
    else
      redirect_to login_path, :notice=>"Registration is closed."
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user,:notice=>"User was successfully created"
    else
      render :action=>'edit'
    end
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def activate
    user=User.where("activation_code=?", params[:activation_code]).first
    if user and user.activate and user.save
      Notification.activated_email(user).deliver
      flash[:notice] = "Successfully activated..."
    else
      flash[:error] = "Some error"
    end
    redirect_to users_path
  end

  private
  def choose_layout
    %'new create'.include?(action_name) ? 'sign' : 'application'
  end
end

