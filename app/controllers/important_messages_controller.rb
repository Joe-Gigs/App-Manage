class ImportantMessagesController < ApplicationController

  def index
    @app = App.find(params[:app_id])
    @important_messages = ImportantMessage.all
  end

  def new
    @important_message = ImportantMessage.new
  end

  def create
    @app = App.find(params[:app_id])
    @important_message = ImportantMessage.new(important_message_params)
    p @important_message.errors
    respond_to do |format|
      if @important_message.save
        @app.users.find_each do |user|
          ImportantMessagesMailer.important_messages_email(@app, user).deliver_now
        end
        flash[:notice] = 'Message has been sent'
        format.js
      else
        flash[:alert] = 'Message was not sent'
        format.js
      end
    end
  end

  def show
    @app = App.find(params[:app_id])
    @important_message = ImportantMessage.find(params[:id])
    if @important_message.is_read === false
      @important_message.is_read = true
      @important_message.save!
    end
    respond_to :js
  end

  def edit
    @important_message = ImportantMessage.find(params[:app_id])
  end

  def update
    @important_message = ImportantMessage.find(params[:app_id])
    @important_message.update_attributes(important_message_params)
    @important_message.save
    respond_to :js
  end

  def confirm_delete

  end

  def destroy
    @app = App.find(params[:app_id])
    important_message = ImportantMessage.find(params[:id])
    important_message.destroy!
    respond_to do |format|
        flash[:notice] = 'Message has been deleted'
        format.js
    end
  end

  private

  def important_message_params
    params.require(:important_message).permit(:subject, :body).merge(app_id: @app.id)
  end
end


