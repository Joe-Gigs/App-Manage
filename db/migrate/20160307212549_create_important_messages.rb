class CreateImportantMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :important_messages do |t|
      t.string :subject
      t.string :body
      t.integer :app_id
      t.timestamps
    end
  end
end
