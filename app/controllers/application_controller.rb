class ApplicationController < ActionController::Base
  include SessionsHelper

  def require_user_logged_in!
    return if current_user

    flash[:error] = 'You must login to use this feature.'
    redirect_to root_path
  end
end
