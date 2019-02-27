class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
   		t.string :app_name
   		t.string :app_key
   		t.integer :user_id
   		t.integer :agent_id
   		t.integer :super_admin_id
			t.string :debug_key
			t.string :production_key
      t.string :message_id
			t.timestamps
    end
  end
end
