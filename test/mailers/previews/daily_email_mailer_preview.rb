# Preview all emails at http://localhost:3000/rails/mailers/daily_email_mailer
class DailyEmailMailerPreview < ActionMailer::Preview
  def send_daily
    DailyEmailMailer.send_daily(App.first)
  end
end
