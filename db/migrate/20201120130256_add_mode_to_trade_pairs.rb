class AddModeToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :mode, :integer, default: 0
  end
end
