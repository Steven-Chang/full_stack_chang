class AddTranxactableReferenceToTranxactions < ActiveRecord::Migration[5.2]
  def change
  	add_reference :tranxactions, :tranxactable, polymorphic: true, index: true, null: false
  end
end
