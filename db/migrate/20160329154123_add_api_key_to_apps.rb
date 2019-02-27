class AddApiKeyToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :api_key, :string
  end
end
