class Api::V1::AuthController < ApplicationController
  skip_before_action :authorize_request, only: [:signup, :login] 

  def signup
    user = User.new(user_params)
    if user.save
      token = JwtService.encode(user_id: user.id)
      render json: { token: token }
    else
      render json: { errors: user.errors }
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: { token: token }
    else
      render json: { error: "Invalid credentials" }
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
