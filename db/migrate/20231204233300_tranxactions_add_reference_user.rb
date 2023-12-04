class TranxactionsAddReferenceUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :tranxactions, :user, index: true
  end
end
