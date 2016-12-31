class AddAccumulateTimeLimitInSecondsToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :accumulate_time_limit_in_seconds, :integer
  end
end
