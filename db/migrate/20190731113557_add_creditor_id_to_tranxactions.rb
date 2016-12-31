class AddCreditorIdToTranxactions < ActiveRecord::Migration[5.2]
  def change
  	add_reference :tranxactions, :creditor, index: true
  end
end
