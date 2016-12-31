class DropTranxactionTypesAndTranxactablesTables < ActiveRecord::Migration[5.2]
  def change
  	drop_table :tranxaction_types
  	drop_table :tranxactables
  end
end
