class Api::V1::DevicesController < Api::V1::BaseController
  swagger_controller :devices, 'Device Management'

  swagger_api :create do
    summary 'Register Device'
    notes 'Endpoint to register a device'
    param :form, :device_token, :string, :required, "User's device token"
    param :path, :app_key, :string, :required, 'App Key'
  end

  before_action :set_app

  def create
    device = Device.new(device_params(@app))
    if device.save
      render json: {
          status_code: 200,
          message: "Device has been save to app: #{@app.app_name}"
      }
    else
      render json: {
          status_code: 409,
          message: 'Device did not save'
      }
    end
  end

  private

  def set_app
    app = App.find_by(app_key: params[:app_key])
    if app.present?
      @app = app
    else
      render json: {
          status_code: 400,
          message: 'App does not exist'
      }
    end
  end

  def device_params(app)
    params.permit(:device_token).merge(app_id: app.id)
  end
end