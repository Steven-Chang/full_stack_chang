class AddReferenceTranxactablesToTranxactions < ActiveRecord::Migration[5.2]
  def change
  	add_reference :tranxactions, :tranxactable, polymorphic: true, index: true
  end
end
