module SimpleAuth
  def logged_in?
    !current_user.nil?
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      session[:user_id]=nil
    end
    @current_user
  end

  def require_login
    if !logged_in?
      flash[:notice]="Please sign in."
      redirect_to login_path
    end
  end

end

