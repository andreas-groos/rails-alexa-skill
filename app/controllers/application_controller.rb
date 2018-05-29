class ApplicationController < ActionController::Base

  before_action :set_current_user
  
  #
  # Sets an instance variable for the current user
  #
  def set_current_user
    @current_user = nil
    begin
	    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
	  rescue ActiveRecord::RecordNotFound
	  end
  end

  #
  # A filter to ensure the user is signed in.  If not, they go to the home page.
  #
  def verify_signed_in
    redirect_to root_url unless @current_user.present?
  end

  #
  # Helper function to shorten frequent calls to escape sql
  #
  def sanitize(x)
    ActiveRecord::Base.connection.quote x
  end

end
