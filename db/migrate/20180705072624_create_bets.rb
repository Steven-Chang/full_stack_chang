class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.decimal :odds, precision: 18, scale: 8, default: "0.0", null: false

      t.timestamps
    end
  end
end
