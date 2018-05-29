class UserController < ApplicationController

  #
  # This is the action for a user to create an account.
  #
  def create
    params[:email]

    u = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password]
    )

    response = {}
    if u.save
      session[:user_id] = u.id
      response = {success: true, name: u.name, codeword: u.codeword}
    else
      response = {success: false, errors: u.errors.to_hash} 
    end

    render json: response
  end

end
