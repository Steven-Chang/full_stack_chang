class CreditorsAddReferenceUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :creditors, :user, index: true
  end
end
