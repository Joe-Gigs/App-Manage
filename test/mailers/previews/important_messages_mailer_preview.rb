# Preview all emails at http://localhost:3000/rails/mailers/important_messages_mailer
class ImportantMessagesMailerPreview < ActionMailer::Preview
  def important_message
    ImportantMessagesMailer.important_messages_email(App.first, User.first)
  end
end
