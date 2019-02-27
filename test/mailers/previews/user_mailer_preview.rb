# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def user_mailer
    UserMailer.invitation_email('gil@bytefly.com', 'gil', App.last )
  end
end
