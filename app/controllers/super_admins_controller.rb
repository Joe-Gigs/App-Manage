class SuperAdminsController < ApplicationController

  def super_admin_console
    @users = User.all
  end

  def admin_user_show
    @user = User.find(params[:id])
  end

  def user_status
    @user = User.find(params[:id])
  end

  def update_user_status
    @user = User.find(params[:id])
    @user.update_attributes(admin_params)
    @users = User.all
    respond_to :js
  end

  def invite_user
    @user = User.new
  end

  def invite
    if @user.nil?
      InviteNewUserMailer.invite_new_user(params[:fname], params[:lname], params[:email], params[:agent]).deliver_now
      flash[:notice] = 'User added'
      respond_to :js
    end
  end

  def view_delete_user
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @users = User.all
    respond_to :js
  end

  private

  def admin_params
    params.require(:user).permit(:fname, :lname, :password, :email, :agent)
  end
end
