class AddAndUseAccumulateAmount < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :accumulate_amount, :decimal, precision: 15, scale: 10
  end
end
