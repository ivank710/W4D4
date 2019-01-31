class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def logout!
    session[:session_token] = nil
    if current_user
      @current_user.reset_session_token!
    end
    @current_user = nil
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def require_logout
    render :new if logged_in?
  end
end
