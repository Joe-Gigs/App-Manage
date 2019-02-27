class AddIsReadToImportantMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :important_messages, :is_read, :boolean, default: false
  end
end
