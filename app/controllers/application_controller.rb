class ApplicationController < ActionController::Base
  include CanCan
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  #check_authorization unless: :devise_controller?
  #skip_authorization_check
end

