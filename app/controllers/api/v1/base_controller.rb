class Api::V1::BaseController < ActionController::Base
  # before_filter :authenticate_api_key

  def authenticate_api_key
    api_key = params[:api_key]
    @app = App.where(api_key: api_key).first
    unless @app
      render json:{
          error: 'Unauthorized. Please supply api key.'
      }
    end
  end
end
