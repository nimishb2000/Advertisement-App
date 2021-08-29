class UserController < ApplicationController
  class AuthenticationError < StandardError; end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :handle_authentication_error

  def create
    user = User.new(signup_params)
    if user.save
      render json: { message: 'added successfully' }, status: :created
    else
      render json: { error: user.errors }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params.require(:email))
    if user.nil?
      raise AuthenticationError
    end
    raise AuthenticationError unless user.authenticate(params.require(:password))
    token = AuthenticationTokenService.generate(user.id)
    render json: token, status: :created
  end

  private
  def signup_params
    params.require(:user).permit(:first_name, :last_name, :age, :password, :phone_number, :email)
  end

  def parameter_missing(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def handle_authentication_error
    head :unauthorized
  end
end
