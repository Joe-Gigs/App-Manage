class AddEmailFrequencyToImportantMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :important_messages, :email_frequency, :string
  end
end
