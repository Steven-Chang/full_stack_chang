class AddColumnsToTranxactables < ActiveRecord::Migration[5.1]
  def change
    add_column :tranxactables, :resource_type, :string
    add_column :tranxactables, :resource_id, :integer
    add_column :tranxactables, :tranxaction_id, :integer
  end
end
