class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    apps_console_path
  end

end
