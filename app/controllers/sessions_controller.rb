class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.aunthenticate_with_credentials(session_params[:email], session_params[:password]) #User.find_by(email: session_params[:email].downcase)
    if user# && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  private

  def session_params
    params.require(:session).permit(
      :email,
      :password
    )
  end
end
