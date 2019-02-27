class InviteNewUserMailer < ActionMailer::Base
  default from: 'info@managedapps.co'

  def invite_new_user(fname, lname, email, agent)
    mail(:to => email, :subject => 'You have been invited to join the ManagedApps Portal!') do |format|
      format.html {
        render locals: {
            fname: fname,
            lname: lname,
            email: email,
            agent: agent,
            sign_up_link: "http://portal.managedapps.co/users/sign_up/?fname=#{fname}&lname=#{lname}&email=#{email}&agent=#{agent}"
        }
      }
    end
  end
end
