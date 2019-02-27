class ImportantMessagesMailer < ActionMailer::Base
  default from: 'info@managedapps.co'

  def important_messages_email(app, user)
    mail(:to => user.email, :subject => 'You have received an Important Message!') do |format|
      format.html {
        render locals: {
            fname: user.fname,
            email: user.email,
            app_name: app.app_name,
            link_for_messages: "http://portal.managedapps.co/apps/console?app=#{app.id}",
            todays_date: DateTime.now.strftime('%B %d, %Y')
        }
      }
    end
  end
end
