class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  skip_before_action :verify_authenticity_token, if: :json_request?
  
  include SessionsHelper

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      # store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def json_request?
    request.format.json?
  end
end
