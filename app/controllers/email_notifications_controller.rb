class EmailNotificationsController < ApplicationController
  def index
    @app = App.find(params[:app_id])
    @emails = EmailNotification.all
  end

  def new
    @email = EmailNotification.new

  end

  def create
    @app = App.find(params[:id])
    @email = @app.emails.create(email_params)
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private
  def email_params
    params.require(:email).permit
  end

end
