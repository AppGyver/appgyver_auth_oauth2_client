class AppgyverAuth::UserSessionsController < ApplicationController
  before_filter :login_required, :only => [ :destroy ]

  respond_to :html

  # omniauth callback method
  def create
    omniauth = request.env['omniauth.auth']

    session[:user_id] = omniauth['uid']
    session[:user_details] = omniauth

    flash[:notice] = "Successfully signed in as user with ID #{current_user_id}"
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]
    redirect_to root_path
  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  def destroy
    reset_session

    flash[:notice] = 'You have successfully signed out!'
    redirect_to "#{ENV['APPGYVER_AUTH_URL']}/users/sign_out"
  end
end
