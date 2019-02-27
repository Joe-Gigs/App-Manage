class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :device_token
      t.integer :app_id
      t.string :endpoint_arn
    end
  end
end
