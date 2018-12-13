# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update delete]
  before_action :correct_user, only: %i[edit update delete]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      flash.now[:danger] = 'Account cannot be created'
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.where(activated: 1).find_by(id: params[:id])
    redirect_to root_path, flash: { danger: 'User not found' } if @user.nil?
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    return true if logged_in?

    flash[:danger] = 'Login required'
    store_location
    redirect_to login_url
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
