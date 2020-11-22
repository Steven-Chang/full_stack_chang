class AddCredentialReferenceToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_reference :trade_pairs, :credential, foreign_key: true
  end
end
