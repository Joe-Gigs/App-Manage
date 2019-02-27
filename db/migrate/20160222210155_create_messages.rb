class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.integer :app_id
      t.timestamps
    end
  end
end
