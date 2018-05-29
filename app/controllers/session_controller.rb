class SessionController < ApplicationController

  #
  # A user signs in here.  We validate the user account, and set a session.
  #
  def create
    response = {success: false, message: 'invalid credentials, please check your account information and try again.'}

    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      response = {success: true}
    end

    render json: response
  end

  #
  # Logs a user out.  Set the session to nil.
  #
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
