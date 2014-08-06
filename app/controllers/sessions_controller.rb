class SessionsController < ApplicationController
  skip_before_filter :login_required

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to portfolio_index_path
    else
      redirect_to logout_path
    end
  end

  def destroy
    reset_session
    redirect_to '/admin'
  end
end
