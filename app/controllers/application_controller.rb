class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, except: [:index, :show, :index_dogs, :index_cats, :weekly]
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user

  def after_sign_in_path_for(resource)
    edit_user_path
  end

  def set_current_user
    User.current_user = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nickname
  end
end
