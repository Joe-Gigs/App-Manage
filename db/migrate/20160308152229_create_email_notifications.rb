class CreateEmailNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :email_notifications do |t|

      t.timestamps
    end
  end
end
