class DailyEmailMailer < ActionMailer::Base
  default from: 'info@managedapps.co'

  def send_daily(app, user)
    mail(:to => user.email, :subject => 'ManagedApps Stats Report') do |format|
      format.html {
        render locals: {
            fname: user.fname,
            email: user.email,
            app_name: app.app_name,
            total: app.events.count,
            today: app.first_runs_today.count,
            yesterday: app.first_runs_yesterday.count,
            this_week: app.first_runs_this_week.count,
            last_week: app.first_runs_last_week.count,
            this_month: app.first_runs_this_month.count,
            last_month: app.first_runs_last_month.count,
            link_for_app: "http://portal.managedapps.co/apps/console?app=#{app.id}",
            todays_date: DateTime.now.strftime('%B %d, %Y')
        }
      }
    end
  end
end
