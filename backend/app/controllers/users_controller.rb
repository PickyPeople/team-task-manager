class UsersController < ApplicationController
  # POST /signup
  def signup
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # GET /me
  def me
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    decoded = JsonWebToken.decode(token)
    user = User.find_by(id: decoded[:user_id]) if decoded

    if user
      render json: user
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
