desc 'send daily email'
task send_daily_email: :environment do
  App.find_each do |a|
    frequency = a.email_frequency
    if frequency === 'daily'
      a.users.select(:fname, :email).each do |u|
        DailyEmailMailer.send_daily(a, u).deliver!
      end
    elsif frequency === 'weekly'
      if a.last_email_sent.nil?
        a.users.select(:fname, :email).each do |u|
          DailyEmailMailer.send_daily(a, u).deliver!
        end
      elsif a.last_email_sent.beginning_of_day + 1.week <= Time.now
        a.users.select(:fname, :email).each do |u|
          DailyEmailMailer.send_daily(a, u).deliver!
        end
      end
    elsif frequency === 'monthly'
      if a.last_email_sent.nil?
        a.users.select(:fname, :email).each do |u|
          DailyEmailMailer.send_daily(a, u).deliver!
        end
      elsif a.last_email_sent.end_of_month <= Time.now
        a.users.select(:fname, :email).each do |u|
          DailyEmailMailer.send_daily(a, u).deliver!
        end
      end
    end
  end
end