class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :message
      t.string :message_code
      t.integer :app_id
      t.timestamps
    end
  end
end
