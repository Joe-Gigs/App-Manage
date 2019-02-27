class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_action

  # Authentication check for both User + Super Admin
  def authenticate_any!
    if super_admin_signed_in?
      true
    else
      authenticate_user!
    end
  end

  def after_invite_path_for(resource)
    apps_console_path
  end

  def current_app
    @current_app = App.find_by(params[:app_id])
  end

  helper_method :current_app

  def layout_by_action
    if action_name == 'super_admin_console'
      'application_admin'
    else
      'application'
    end
  end
end
