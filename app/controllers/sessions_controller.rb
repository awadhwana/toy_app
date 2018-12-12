# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && (user == user.authenticate(params[:session][:password]))
      flash.now[:success] = "Welcome #{user.name}"
      log_in user # method defined in sessions helper
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid credentials'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:danger] = 'logged out'
    redirect_to root_url
  end
end
