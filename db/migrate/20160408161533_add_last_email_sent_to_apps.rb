class AddLastEmailSentToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :last_email_sent, :datetime
  end
end
