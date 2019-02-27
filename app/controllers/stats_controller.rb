class StatsController < ApplicationController

  respond_to :js

  def all
    @app = App.find(params[:app_id])
  end

  def today
    @app = App.find(params[:app_id]).first_runs_today
    @when = 'today'
  end

  def total
    @app = App.find(params[:app_id])
  end

  def yesterday
    @app = App.find(params[:app_id]).first_runs_yesterday

  end

  def saturday
    @app = App.find(params[:app_id])
  end

  def sunday
    @app = App.find(params[:app_id])
  end

  def weekend_stats
    @app = App.find(params[:app_id])
  end

  def this_week
    @app = App.find(params[:app_id]).first_runs_this_week
    @when = 'This week'
  end

  def last_week
    @app = App.find(params[:app_id]).first_runs_last_week
    @when = 'Last week'
  end

  def this_month
    @app = App.find(params[:app_id]).first_runs_this_month
    @when = 'This month'
  end

  def last_month
    @app = App.find(params[:app_id]).first_runs_last_month
    @when = 'Last month'
  end
end
