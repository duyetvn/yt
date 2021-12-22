module Users
  class SessionsController < ApplicationController
    include SessionsHelper

    def create
      user = User.find_by(email: user_params[:email])
      validate_user(user)
      redirect_to root_path
    end

    def destroy
      session.delete(:user_id)
      flash[:success] = "Sign out successfully!"
      redirect_to root_path
    end

    private

    def validate_user(user)
      flash[:invalid_fields] = {}
      flash[:invalid_fields][:email] = user_params[:email]

      if user&.authenticate(user_params[:password])
        flash[:success] = "Sign in successfully!"
        log_in user
      elsif user
        flash[:error] = "Wrong email or password."
      else
        create_new_user
      end
    end

    def create_new_user
      user = User.new(user_params)
      if user.save
        log_in user
        flash[:success] = "Your account is created successfully"
      else
        flash[:error] = user.errors.full_messages
      end
    end

    def user_params
      params.require(:users).permit(:email, :password)
    end
  end
end
