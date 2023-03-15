# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def create
    super do 
    user = User.authenticate_by(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid Email or password'
      render :new
    end
  end
  end
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
