class AddEnabledToCredentials < ActiveRecord::Migration[6.0]
  def change
    add_column :credentials, :enabled, :boolean, default: true
  end
end
