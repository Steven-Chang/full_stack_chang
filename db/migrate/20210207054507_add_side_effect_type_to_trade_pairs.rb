class AddSideEffectTypeToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :side_effect_type, :integer, default: 0, null: false
  end
end
