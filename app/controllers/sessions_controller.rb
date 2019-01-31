class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if user 
      log_in_user!(user)
      #redirect_to user_url(user)
      render json: user
    else
      #show errors
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end