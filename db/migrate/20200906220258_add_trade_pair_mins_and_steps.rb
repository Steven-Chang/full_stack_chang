class AddTradePairMinsAndSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :minimum_total, :decimal, precision: 8, scale: 2, default: 0, null: false
    add_column :trade_pairs, :amount_step, :decimal, precision: 8, scale: 2, default: 0, null: false
  end
end
