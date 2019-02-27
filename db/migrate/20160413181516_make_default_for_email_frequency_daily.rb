class MakeDefaultForEmailFrequencyDaily < ActiveRecord::Migration[5.0]
  def change
  	change_column :apps, :email_frequency, :string, :default => 'daily'
  end
end
