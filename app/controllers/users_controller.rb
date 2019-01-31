class UsersController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end