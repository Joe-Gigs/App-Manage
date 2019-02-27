class AddEmailFrequencyToApps < ActiveRecord::Migration[5.0]
  def change
  	add_column :apps, :email_frequency, :string
  end
end
