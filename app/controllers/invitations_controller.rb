class InvitationsController < ApplicationController
  before_action :set_app
  before_action :set_user, except:[:invite_form, :show_destroy]
  before_action :set_user_id, only: :show_destroy


  def invite_form
    @apps = @app.users
  end

  def agent_invite_form
    @apps = @app.users
  end

  def create
    if @user.nil?
      UserMailer.invitation_email(params[:email], params[:fname], params[:lname], @app).deliver_now
      flash[:notice] = 'Sent email Invitation'
    else
      @app.users << @user
      flash[:notice] = 'Added user to app'
    end
    @users = @app.users
    respond_to :js
  end

  def show_destroy

  end

  def destroy
    # We want to destroy the relationship between a user and and App.
  end

  private

  def set_user
    user = User.find_by(email: params[:email])
    @user = user if user
  end

  def set_user_id
    user = User.find(params[:user_id])
    if user.nil?
      flash[:notice] = "User not on file"
      redirect_to apps_console_path
      # elsif user.present?
      #   flash[:notice] = "Already part of this project!"
      #   redirect_to apps_console_path
    else
      @user = user
    end
  end

  def set_app
    app = App.find(params[:app_id])
    if app.nil?
      flash[:notice] = "App not on file"
      redirect_to apps_console_path
    else
      @app = app
    end
  end
end
