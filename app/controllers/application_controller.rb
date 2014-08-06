class ApplicationController < ActionController::Base
  protect_from_forgery
  prepend_before_filter :login_required
  helper_method :logged_in?

  def logged_in?
    !!current_user
  end

  def current_user
    @user ||= User.where(id: session[:user_id]).first
  end

  def login_required
    redirect_to root_path unless current_user
  end
end
