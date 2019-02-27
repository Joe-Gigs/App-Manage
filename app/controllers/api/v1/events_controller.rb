class Api::V1::EventsController < Api::V1::BaseController

  def first_run
    app = App.find_by(app_key: params[:app_key])
    if app
      Event.create(message: 'First time run logged.', app_id: app.id, message_code: 'FTR')
      render json: {
          status_code: '200',
          messages: 'First run logged',
          first_runs: app.first_runs_total
      }
    else
      render json: {
          status_code: '400',
          messages: 'First run not logged. Check App Key'
      }
    end
  end

  def app_session
    app = App.find_by(app_key: params[:app_key])
    if app
      Event.create(message: 'App Session logged.', app_id: app.id, message_code: 'SES')
      render json: {
          status_code: '100',
          messages: 'App Session logged',
          sessions: app.app_session_total
      }
    else
      render json: {
          status_code: '300',
          messages: 'App Session not logged. Check App Key'
      }
    end
  end
end

