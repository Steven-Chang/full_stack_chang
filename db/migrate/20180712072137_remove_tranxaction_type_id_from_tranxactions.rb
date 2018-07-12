class RemoveTranxactionTypeIdFromTranxactions < ActiveRecord::Migration[5.1]
  def change
    remove_column :tranxactions, :tranxaction_type_id, :integer
  end
end
