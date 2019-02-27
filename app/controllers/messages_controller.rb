class MessagesController < ApplicationController

  def index
    @app = App.find(params[:app_id])

    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @app = App.find(params[:app_id])
    @message = @app.messages.create(message_params)
    if @message.save
      flash[:notice] = 'Push notification has been sent'
      respond_to :js
    else
      flash[:alert] = 'Push notification has been sent'
      respond_to :js
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update
      redirect_to @message
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end
