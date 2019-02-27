class UserMailer < ActionMailer::Base
  default from: 'info@managedapps.co'

  def invitation_email(email, fname, lname, app)
    if app
      name = app.app_name
      key = app.app_key
    end
    mail(:to => email, :subject => 'You have been invited to the ManagedApps portal!') do |format|
      format.html {
        render locals: {
            fname: fname,
            lname: lname,
            email: email,
            app_name: name,
            sign_up_link: "http://portal.managedapps.co/users/sign_up/?fname=#{fname}&lname=#{lname}&app=#{key}&email=#{email}",
            todays_date: DateTime.now.strftime('%B %d, %Y')
        }
      }
    end
  end
end
