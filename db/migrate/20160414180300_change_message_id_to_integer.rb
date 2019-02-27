class ChangeMessageIdToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :apps, :message_id, :integer
  end
end
