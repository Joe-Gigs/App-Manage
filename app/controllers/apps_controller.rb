class AppsController < ApplicationController
  before_action :authenticate_any!

  def console
    @apps = current_super_admin ? App.all : current_user.apps
    @app = App.new
  end

  def new
    @app = App.new
  end

  def app_count
    respond_to :js
  end

  def create
    @apps = current_super_admin ? App.all : current_user.apps
    app = App.new(app_params)
    respond_to do |format|
      if app.save
        app.users << current_user if current_user
        flash[:notice] = 'Your new app has been successfully created'
        format.js
      else
        flash[:alert] = 'App not saved'
        format.js
      end
    end
  end

  def show
    @app = App.find(params[:id])
  end

  def show_users
    @app = App.find(params[:app_id])
    @users = @app.get_users
    @super_admins = @app.get_super_admins
  end

  def update
    @app = App.find(params[:app_id])
    @app.update_attributes(app_params)
    @app.save
    flash[:notice] = 'Information Updated'
    respond_to :js
  end

  def config_push_notifications
    @app = App.find(params[:app_id])
    respond_to :js
  end

  def config_users
    @app = App.find(params[:app_id])
    @users = @app.users
  end

  def email_frequency # get action
    @app = App.find(params[:app_id])
    respond_to :js
  end

  def email_frequency_update #post action
    @app = App.find(params[:app_id])
    respond_to do |format|
      if @app.update_attributes(app_params)
        flash[:notice] = 'Email configurations updated'
        format.js
      else
        flash[:alert] = 'Email configurations were not updated'
      end
    end
  end

  def show_user
    @user = User.find(params[:user_id])
    respond_to :js
  end

  def remove_user_association
    @app = App.find(params[:app_id])
    the_user = User.find(params[:user_id])
    @app.users.delete(the_user)
    @users = @app.users
    flash[:notice] = 'User removed from app'
    respond_to :js
  end

  def app_key
    @app = App.find(params[:id])
  end

  def view_delete
    @app = App.find(params[:app_id])
    # @app.destroy
    # redirect_to apps_console_path
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy
    flash[:notice] = 'App deleted'
    @apps = current_super_admin ? App.all : current_user.apps
    respond_to :js
  end

  # def user_status
  #   @user.find(params[:id])
  # end
  #
  # def update_user_status
  #   @user.find(params[:id])
  #   @user.update_attributes(app_params)
  # end

  private

  def app_params
    id = current_user ? current_user.id : nil
    params.require(:app).permit(:app_name, :app_key, :debug_key, :production_key, :email_frequency).merge(user_id: id)
  end
end
