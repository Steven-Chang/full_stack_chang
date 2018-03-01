class RentTransaction < ActiveRecord::Base

  def self.get_bond_for_user( user_id )
    bond_transactions = RentTransaction.where(:user_id => user_id).where(:description => "bond")
    if bond_transactions.length > 0
      bond_transactions.first.amount
    else
      0
    end
  end

  def self.get_balance_for_user( user_id )
    RentTransaction.where(:user_id => user_id).sum(:amount)
  end

end
