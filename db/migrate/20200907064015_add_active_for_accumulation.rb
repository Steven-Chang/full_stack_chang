class AddActiveForAccumulation < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :active_for_accumulation, :boolean
  end
end
