class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :date, :date
  end
end
